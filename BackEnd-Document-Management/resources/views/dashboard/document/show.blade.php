@extends('dashboard.layouts.main')

@section('container')
    <main>
        <div class="my-3 text-center">
            <h2>Detail Document</h2>
            <div class="row my-3">
                <div class="col-lg-12">
                    <h5 for="documentName" class="form-label">Document Name</h5>
                    <input type="text" class="form-control text-center" id="documentName" placeholder=""
                        value="{{ $document->document_name }}" disabled>
                </div>
                <div class="col-lg-6">
                    <h5 for="organizationName" class="form-label">Organization Name</h5>
                    <input type="text" class="form-control text-center" id="organizationName" placeholder=""
                        value="{{ $document->organization_name }}" disabled>
                </div>
                <div class="col-lg-6">
                    <h5 for="date" class="form-label">Date</h5>
                    <input type="text" class="form-control text-center" id="date" placeholder=""
                        value="{{ $document->date }}" disabled>
                </div>
                <div class="col-lg-6">
                    <h5 for="type" class="form-label">Type</h5>
                    <input type="text" class="form-control text-center" id="type" placeholder=""
                        value="{{ $document->type->type_name }}" disabled>
                </div>
                <div class="col-lg-6">
                    <h5 for="category" class="form-label">Category</h5>
                    <input type="text" class="form-control text-center" id="category" placeholder=""
                        value="{{ $document->category->category_name }}" disabled>
                </div>
                <div class="col-lg-6">
                    <h5 for="status" class="form-label">Status</h5>
                    <input type="text" class="form-control text-center" id="status" placeholder=""
                        value="{{ $document->status->status_name }}" disabled>
                </div>
                <div class="col-lg-6">
                    <h5 for="fileUpload" class="form-label">File Uploaded</h5>
                    <input type="text" class="form-control text-center" id="fileUpload" placeholder=""
                        value="{{ $document->file_upload }}" disabled>
                </div>
                <div class="col-lg-6">
                    <h5 for="signature" class="form-label">Signature</h5>
                    <input type="text" class="form-control text-center" id="signature" placeholder=""
                        value="{{ $document->signature }}" disabled>
                </div>
                <div class="col-lg-6">
                    <h5 for="owner" class="form-label">Owner</h5>
                    <input type="text" class="form-control text-center" id="owner" placeholder=""
                        value="{{ $document->user->username }}" disabled>
                </div>
                <div class="col-lg-6">
                    <h5 for="createdAt" class="form-label">Created At</h5>
                    <input type="text" class="form-control text-center" id="createdAt" placeholder=""
                        value="{{ $document->created_at }}" disabled>
                </div>
                <div class="col-lg-6">
                    <h5 for="updatedAt" class="form-label">Updated At</h5>
                    <input type="text" class="form-control text-center" id="updatedAt" placeholder=""
                        value="{{ $document->updated_at }}" disabled>
                </div>
                <div class="my-2">
                    <a href="/dashboard/documents" class="btn btn-success"><span data-feather="arrow-left"></span>Back to
                        All Documents</a>
                    <a href="/dashboard/documents/{{ $document->id }}/edit" class="btn btn-warning"><span
                            data-feather="edit"></span>Edit</a>
                    <form action="/dashboard/documents/{{ $document->id }}" method="POST" class="d-inline">
                        @method('delete')
                        @csrf
                        <button class="btn btn-danger" onclick="return confirm('Are you sure?')"><span
                                data-feather="x-circle"></span>Delete</button>
                    </form>
                </div>
            </div>
    </main>

    <script src="../assets/dist/js/bootstrap.bundle.min.js"></script>

    <script src="form-validation.js"></script>
@endsection
