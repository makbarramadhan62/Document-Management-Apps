<?php

namespace App\Http\Controllers;

use App\Models\Document;
use Illuminate\Http\Request;

class DocumentApiController extends Controller
{
    public function index()
    {
        $documents = Document::getDocument();
        return response()->json($documents);
    }

    public function store(Request $request)
    {
        $data = $request->all();

        if ($request->file('file_upload')) {
            $fileName = $request->file('file_upload')->getClientOriginalName();
            $fileUpload = $request->file('file_upload')->storeAs('document-uploads', $fileName);
            $data['file_upload'] = $fileUpload;
        }

        if ($request->file('signature')) {
            $fileName = $request->file('signature')->getClientOriginalName();
            $fileUpload = $request->file('signature')->storeAs('signature-uploads', $fileName);
            $data['signature'] = $fileUpload;
        }

        Document::create($data);

        // $document = Document::create($request->all());
        // return response()->json(['message' => 'Input Data Success', 'data' => $document]);
    }

    public function show($id)
    {
        $document = Document::find($id);
        return response()->json(['message' => 'Show Data Success', 'data' => $document]);
    }

    public function update(Request $request, $id)
    {
        $document = Document::find($id);
        $document->update($request->all());
        return response()->json(['message' => 'Update Data Success', 'data' => $document]);
    }

    public function destroy($id)
    {
        $document = Document::find($id);
        $document->delete();
        return response()->json(['message' => 'Delete Data Success', 'data' => null]);
    }
}
