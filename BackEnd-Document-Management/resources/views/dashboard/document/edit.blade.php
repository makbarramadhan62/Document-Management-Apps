@extends('dashboard.layouts.main')

@section('container')
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">Edit Document</h1>
    </div>

    <div class="col-lg-8">
        <form method="post" action="/dashboard/documents/{{ $document->id }}">
            @method('put')
            @csrf
            <div class="mb-3">
                <label for="document_name" class="form-label">Document Name</label>
                <input type="text" class="form-control @error('document_name') is-invalid @enderror" id="document_name"
                    name="document_name" value="{{ $document->document_name }}">
            </div>
            <div class="mb-3">
                <label for="organization_name" class="form-label">Organization Name</label>
                <input type="text" class="form-control" id="organization_name" name="organization_name"
                    value="{{ $document->organization_name }}">
            </div>
            <div class="mb-3">
                <label for="date" class="form-label">Date</label>
                <input type="text" class="form-control" id="date" name="date" value="{{ $document->date }}">
            </div>
            <div class="mb-3">
                <label for="type" class="form-label">Type</label>
                <select class="form-select" name="type_id">
                    @foreach ($types as $type)
                        @if (old('type_id', $document->type_id) == $type->id)
                            <option value="{{ $type->id }}" selected>{{ $type->type_name }}</option>
                        @else
                            <option value="{{ $type->id }}">{{ $type->type_name }}</option>
                        @endif
                    @endforeach
                </select>
            </div>
            <div class="mb-3">
                <label for="category" class="form-label">Category</label>
                <select class="form-select" name="category_id">
                    @foreach ($categories as $category)
                        @if (old('category_id', $document->category_id) == $category->id)
                            <option value="{{ $category->id }}" selected>{{ $category->category_name }}</option>
                        @else
                            <option value="{{ $category->id }}">{{ $category->category_name }}</option>
                        @endif
                    @endforeach
                </select>
            </div>
            <div class="mb-3">
                <label for="status" class="form-label">Status</label>
                <select class="form-select" name="status_id">
                    @foreach ($statuses as $status)
                        @if (old('status_id', $document->status_id) == $status->id)
                            <option value="{{ $status->id }}" selected>{{ $status->status_name }}</option>
                        @else
                            <option value="{{ $status->id }}">{{ $status->status_name }}</option>
                        @endif
                    @endforeach
                </select>
            </div>
            <div class="mb-3">
                <label for="file_upload" class="form-label">File Upload</label>
                <input type="text" class="form-control" id="file_upload" name="file_upload"
                    value="{{ $document->file_upload }}">
            </div>
            <div class="mb-3">
                <label for="signature" class="form-label">Signature</label>
                <input type="text" class="form-control" id="signature" name="signature"
                    value="{{ $document->signature }}">
            </div>
            {{-- <div class="mb-3">
                <label for="user" class="form-label">Owner</label>
                <select class="form-select" name="user_id">
                    @foreach ($users as $user)
                        @if (old('user_id', $document->user_id) == $user->id)
                            <option value="{{ $user->id }}" selected>{{ $user->username }}</option>
                        @else
                            <option value="{{ $user->id }}">{{ $user->username }}</option>
                        @endif
                    @endforeach
                </select>
            </div> --}}
            <button type="submit" class="btn btn-primary">Update</button>
        </form>
    </div>
@endsection
