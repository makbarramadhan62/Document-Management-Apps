@extends('dashboard.layouts.main')

@section('container')
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">All Documents</h1>
    </div>

    @if (session()->has('success'))
        <div class="alert alert-primary" role="alert">
            {{ session('success') }}
        </div>
    @endif

    <div class="table-responsive">
        <a href="/dashboard/documents/create" class="btn btn-primary mb-3">Add New Document</a>
        <table class="table table-striped table-sm">
            <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Name</th>
                    <th scope="col">Orgnaization</th>
                    <th scope="col">Category</th>
                    <th scope="col">Status</th>
                    <th scope="col">Created</th>
                    <th scope="col">Updated</th>
                    <th scope="col">Action</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($documents as $document)
                    <tr>
                        <td>{{ $loop->iteration }}</td>
                        <td>{{ $document->document_name }}</td>
                        <td>{{ $document->organization_name }}</td>
                        <td>{{ $document->category->category_name }}</td>
                        <td>{{ $document->status->status_name }}</td>
                        <td>{{ $document->created_at }}</td>
                        <td>{{ $document->updated_at }}</td>
                        <td>
                            <a href="documents/{{ $document->id }}" class="badge bg-info"><span
                                    data-feather="eye"></span></a>
                            <a href="documents/{{ $document->id }}/edit" class="badge bg-warning"><span
                                    data-feather="edit"></span></a>
                            <form action="documents/{{ $document->id }}" method="POST" class="d-inline">
                                @method('delete')
                                @csrf
                                <button class="badge bg-danger border-0" onclick="return confirm('Are you sure?')"><span
                                        data-feather="x-circle"></span></button>
                            </form>
                        </td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    </div>
@endsection
