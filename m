Return-Path: <linux-efi+bounces-2305-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 228589E69FB
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 10:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D942518858A2
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 09:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762981DA10C;
	Fri,  6 Dec 2024 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOOPzg9x"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ACE1CD219
	for <linux-efi@vger.kernel.org>; Fri,  6 Dec 2024 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477078; cv=none; b=TWCpqhuQZMtvTBq74hPiNSWoOXCqm9HGzWN86WtWVNlwJMDAbFMjC+qlndGKHBpDoJ5983HdbBo45l3qQKEBEKL4vBn7V8k7bUSGjld4m5iUyrUqdb1LZoWsLRO8IQ2M1a8OELksyrYrA9Ryk2LqQ6nP/spRHzacd7i589tKMCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477078; c=relaxed/simple;
	bh=gDs9W6D25M+274Ub/RkBCzEtBozqBZAxGtIrI/DcyhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVPyrQ3kmGUhVZKmdqb7U7l+JzDiyAEjTp/AzBBCW3y6vXFv6xTkjZ/ErYR3My/9NKHWJfEImPTJ9omDW+kejV/XSz6PHhfoQU2SlqZrgcxLx424gRGLVCJ445d6cXZBHWZ1aJVfWAPm/WEeXrna6XcUGkkjmG7ckcKr1JdopBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QOOPzg9x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733477075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U7RulJdapZ2on+Jnt3j3HqdNew8bzmYyaffOSAwhhFs=;
	b=QOOPzg9xlUh/gz2rFu73HjyfFnxXUfzciVrFh8gzwa1Vp/klgXabgHHihUQ3twDvH2Syk3
	ymjjpicvVU15qqugS7RYnkiRySAY9AFKFdD/Y2QVFNUztUykIHhAxLdfXDGHjAad2N9Iq4
	D9czpvB6tAi+LISaPXNlS7VCpwLffOs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-5vtDuTxTP82xl-gR3GLk0A-1; Fri,
 06 Dec 2024 04:24:31 -0500
X-MC-Unique: 5vtDuTxTP82xl-gR3GLk0A-1
X-Mimecast-MFC-AGG-ID: 5vtDuTxTP82xl-gR3GLk0A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA5B11955E8C;
	Fri,  6 Dec 2024 09:24:30 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.39.192.129])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A0981955F3F;
	Fri,  6 Dec 2024 09:24:30 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
	id 2DE7B2541D8; Fri,  6 Dec 2024 10:24:27 +0100 (CET)
Date: Fri, 6 Dec 2024 10:24:27 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Pingfan Liu <piliu@redhat.com>, Peter Jones <pjones@redhat.com>, 
	linux-efi@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 1/2] Makefile.zboot: Sign Image before packing into
 EFI-STUB shell
Message-ID: <cc6cpx74vzfzivvob4d3smutdjisvgjz6wjob5tay47ubb5lje@exjqpfyxdg3w>
References: <20241206021000.8953-1-piliu@redhat.com>
 <20241206021000.8953-2-piliu@redhat.com>
 <CAMj1kXGFnwdQZzb_t5kC8nGyDz+MQ0wq6s2oTGNBmV7ebVgSGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGFnwdQZzb_t5kC8nGyDz+MQ0wq6s2oTGNBmV7ebVgSGA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Dec 06, 2024 at 09:03:30AM +0100, Ard Biesheuvel wrote:
> (cc Peter, Gerd)
> 
> On Fri, 6 Dec 2024 at 03:10, Pingfan Liu <piliu@redhat.com> wrote:
> >
> > At present, the kexec_file_load of either zboot or UKI kernel relies on
> > the user space to parse and extract the Image, and then pass the Image
> > through that syscall. During this process, the outmost signature on
> > zboot or UKI kernel is stripped and discarded.
> >
> > On the other hand, a secure boot platform enforces the signature
> > verfiication on the kernel image passed through the kexec_file_load
> > syscall. To cater to this requirement, this patch applies signature on
> > the PE format 'Image' before padding.
> 
> The whole point of the EFI zboot format was avoiding the need to sign
> the compressed payload.

Also note that signing things that way does not work with the usual
distro signing workflows  They typically do first the whole build
process, then go sign the final kernel image with a somewhat evolved
process because the signing keys are kept on secure hardware tokens.

When it comes to UKIs discarding the outmost signature is bad from a
security point of view, because that is the only signature which also
covers the initrd data.

> Perhaps we should just make EFI zboot gzip-only, rather than
> supporting 7 different compression methods because that is what the
> legacy decompressors on ARM and x86 support - I struggle to see the
> point of that tbh (even though I implemented that myself)

We have 7 meanwhile?  Wow.  That looks somewhat insane indeed.

> That way, the kernel can authenticate the outer PE zboot image as
> usual, and perform the decompression itself, without having to carry
> code for all compression formats it might encounter.

gzip was the only one for a looooong time, so we want probably keep
that.  It also is somewhat dated and doesn't offer the best compression
rations, so I do the point in supporting some better alternative.  But
can we settle on *one* gzip alternative, reducing the total number from
seven to two?  Reasonable choice for the alternative would IMHO be:

  (1) xz - that seems to have established as *the* gzip alternative,
      release tarballs are either .gz or .xz these days, everything
      else is rather exotic.

  (2) zstd - typical distro kernels need that *anyway* because there
      are more in-kernel users, btrfs uses zstd compression for example.

distro data points:  fedora/x64 used gzip in the past and uses zstd
compression today.  fedora/aa64 uses gzip for zboot.

take care,
  Gerd


