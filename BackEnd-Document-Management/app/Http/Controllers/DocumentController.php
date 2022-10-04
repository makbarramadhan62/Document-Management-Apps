<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Document;
use App\Models\Status;
use App\Models\Type;
use App\Models\User;
use Illuminate\Http\Request;

class DocumentController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('dashboard.document.index', [
            'documents' => Document::all(),
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('dashboard.document.create', [
            'types' => Type::all(),
            'categories' => Category::all(),
            'statuses' => Status::all(),
            'users' => User::all()
        ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
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
        return redirect('/dashboard/documents')->with('success', 'New Document has been Added!');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Document  $document
     * @return \Illuminate\Http\Response
     */
    public function show(Document $document)
    {
        return view('dashboard.document.show', [
            'document' => $document,
            'types' => Type::all(),
            'categories' => Category::all(),
            'statuses' => Status::all(),
            'users' => User::all()
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Document  $document
     * @return \Illuminate\Http\Response
     */
    public function edit(Document $document)
    {
        return view('dashboard.document.edit', [
            'document' => $document,
            'types' => Type::all(),
            'categories' => Category::all(),
            'statuses' => Status::all(),
            'users' => User::all()
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Document  $document
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Document $document)
    {
        Document::where('id', $document->id)->update([
            'document_name' => $request->input('document_name'),
            'organization_name' => $request->input('organization_name'),
            'date' => $request->input('date'),
            'type_id' => $request->input('type_id'),
            'category_id' => $request->input('category_id'),
            'status_id' => $request->input('status_id'),
            'file_upload' => $request->input('file_upload'),
            'signature' => $request->input('signature'),
            'user_id' => $request->input('user_id'),
        ]);

        return redirect('/dashboard/documents')->with('success', 'Document has been Updated!');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Document  $document
     * @return \Illuminate\Http\Response
     */
    public function destroy(Document $document)
    {
        Document::destroy($document->id);

        return redirect('/dashboard/documents')->with('success', 'Document has been Deleted!');
    }
}
