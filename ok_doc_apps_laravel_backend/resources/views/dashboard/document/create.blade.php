@extends('dashboard.layouts.main')

@section('container')
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">Add New Document</h1>
    </div>

    <div class="col-lg-8">
        <form method="post" action="/dashboard/documents" enctype="multipart/form-data">
            @csrf
            <div class="mb-3">
                <label for="document_name" class="form-label">Document Name</label>
                <input type="text" class="form-control @error('document_name') is-invalid @enderror" id="document_name"
                    name="document_name">
            </div>
            <div class="mb-3">
                <label for="organization_name" class="form-label">Organization Name</label>
                <input type="text" class="form-control" id="organization_name" name="organization_name">
            </div>
            <div class="mb-3">
                <label for="date" class="form-label">Date</label>
                <input type="date" class="form-control" id="date" name="date">
            </div>
            <div class="mb-3">
                <label for="type" class="form-label">Type</label>
                <select class="form-select" name="type_id">
                    @foreach ($types as $type)
                        <option value="{{ $type->id }}">{{ $type->type_name }}</option>
                    @endforeach
                </select>
            </div>
            <div class="mb-3">
                <label for="category" class="form-label">Category</label>
                <select class="form-select" name="category_id">
                    @foreach ($categories as $category)
                        <option value="{{ $category->id }}">{{ $category->category_name }}</option>
                    @endforeach
                </select>
            </div>
            <div class="mb-3">
                <label for="status" class="form-label">Status</label>
                <select class="form-select" name="status_id">
                    @foreach ($statuses as $status)
                        <option value="{{ $status->id }}">{{ $status->status_name }}</option>
                    @endforeach
                </select>
            </div>
            <div class="mb-3">
                <label for="file_upload" class="form-label">Upload File</label>
                <input class="form-control" type="file" id="file_upload" name="file_upload">
            </div>
            <div class="mb-3">
                <label for="signature" class="form-label">Signature</label>
                <input class="form-control" type="file" id="signature" name="signature">
            </div>
            <div class="mb-3">
                <label for="user_id" class="form-label">Owner</label>
                <select class="form-select" name="user_id">
                    @foreach ($users as $user)
                        <option value="{{ $user->id }}">{{ $user->username }}</option>
                    @endforeach
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>
@endsection
