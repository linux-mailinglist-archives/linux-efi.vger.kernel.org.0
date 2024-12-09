Return-Path: <linux-efi+bounces-2321-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9379E8964
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 03:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 140181639C6
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 02:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEB525777;
	Mon,  9 Dec 2024 02:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsDTo6XV"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8944C91
	for <linux-efi@vger.kernel.org>; Mon,  9 Dec 2024 02:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733713191; cv=none; b=V7s+tQA6tJl7Ip2PxurF/NwUurRyXgUjfEiot2hoUEBticY4lOvLZinxhcrzVP3jaa27NCtkgRzprCAazVHv9LGDj8xc48p8DLzjOao/dazTcvfW2aOOgHkSVW7viorVWOgWr6OiK5nJY2HsLnxGmKeHOK0S/JHwWOpK5WLbxr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733713191; c=relaxed/simple;
	bh=/8/HOI/Xfb6BnjlcRS0wco/Gf7t/CTHX9i8ghHoexu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVPMsfrpJRZZFq9NoOy0LUKoYeyL6E2Mr7q6j77Icaz2YSM4hsGppDp2MEjN/ucvViqLpN8+nm4NagQXa7fvyxy0wZduJZdqrtgaeSLIpoxTt9IME8ashB8g5rUtYhDYgtTh0Y4Ri8iaNf4GgzkH1+saJjWLjQnmu84n/kiExZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsDTo6XV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733713189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26DCZ7zgqsyiQM0msb6uRK8Nbub9pDRHZ0IzZkKEA9o=;
	b=gsDTo6XVyEituOeCBNJjEPRsC9rbBzXGdcwRpNG+6w3LkIZrW7jqpPdRMyEQI05CiGZN1B
	pp3I6tFpY/s01nhRPcCwQqXrjfasMsIXOzRy/x6LFBHY4T5hgMqXujOTWnbGqwKgWVVYIP
	ieLFjRnUgq2frgpTf8FyckVhkNkhBhs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-NqrKeZjmN0iUxtMOZHUlXQ-1; Sun,
 08 Dec 2024 21:59:46 -0500
X-MC-Unique: NqrKeZjmN0iUxtMOZHUlXQ-1
X-Mimecast-MFC-AGG-ID: NqrKeZjmN0iUxtMOZHUlXQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD6FD1955E89;
	Mon,  9 Dec 2024 02:59:44 +0000 (UTC)
Received: from localhost (unknown [10.72.112.98])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A26F19560A2;
	Mon,  9 Dec 2024 02:59:42 +0000 (UTC)
Date: Mon, 9 Dec 2024 10:59:40 +0800
From: Pingfan Liu <piliu@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>,
	linux-efi@vger.kernel.org, Will Deacon <will@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 1/2] Makefile.zboot: Sign Image before packing into
 EFI-STUB shell
Message-ID: <Z1ZdHI4uEUckaKC6@fedora>
References: <20241206021000.8953-1-piliu@redhat.com>
 <20241206021000.8953-2-piliu@redhat.com>
 <CAMj1kXGFnwdQZzb_t5kC8nGyDz+MQ0wq6s2oTGNBmV7ebVgSGA@mail.gmail.com>
 <cc6cpx74vzfzivvob4d3smutdjisvgjz6wjob5tay47ubb5lje@exjqpfyxdg3w>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc6cpx74vzfzivvob4d3smutdjisvgjz6wjob5tay47ubb5lje@exjqpfyxdg3w>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Dec 06, 2024 at 10:24:27AM +0100, Gerd Hoffmann wrote:
> On Fri, Dec 06, 2024 at 09:03:30AM +0100, Ard Biesheuvel wrote:
> > (cc Peter, Gerd)
> > 
> > On Fri, 6 Dec 2024 at 03:10, Pingfan Liu <piliu@redhat.com> wrote:
> > >
> > > At present, the kexec_file_load of either zboot or UKI kernel relies on
> > > the user space to parse and extract the Image, and then pass the Image
> > > through that syscall. During this process, the outmost signature on
> > > zboot or UKI kernel is stripped and discarded.
> > >
> > > On the other hand, a secure boot platform enforces the signature
> > > verfiication on the kernel image passed through the kexec_file_load
> > > syscall. To cater to this requirement, this patch applies signature on
> > > the PE format 'Image' before padding.
> > 
> > The whole point of the EFI zboot format was avoiding the need to sign
> > the compressed payload.
> 
> Also note that signing things that way does not work with the usual
> distro signing workflows  They typically do first the whole build
> process, then go sign the final kernel image with a somewhat evolved
> process because the signing keys are kept on secure hardware tokens.
> 

I beg to differ. This apporoach just reuses signing method used by the
kernel module.

> When it comes to UKIs discarding the outmost signature is bad from a
> security point of view, because that is the only signature which also
> covers the initrd data.
> 

Yes, that is a significant challenge.  For UKI, in another rely, I
mentioned about the solution of "UKI format parser in linux kernel". 

This series of approaches is specifically targeted at the zboot format
in the absence of a kernel zboot format parser.  for zboot format if
there is no kernel zboot format parser.  (That is the 'kexec-related
maintenance nightmare', which Ard mentioned.)

In fact, there have been multiple attempts to address the
kexec_file_load signature PE issue, but each of these approaches has
inherent limitations

Thanks,

Pingfan

> > Perhaps we should just make EFI zboot gzip-only, rather than
> > supporting 7 different compression methods because that is what the
> > legacy decompressors on ARM and x86 support - I struggle to see the
> > point of that tbh (even though I implemented that myself)
> 
> We have 7 meanwhile?  Wow.  That looks somewhat insane indeed.
> 
> > That way, the kernel can authenticate the outer PE zboot image as
> > usual, and perform the decompression itself, without having to carry
> > code for all compression formats it might encounter.
> 
> gzip was the only one for a looooong time, so we want probably keep
> that.  It also is somewhat dated and doesn't offer the best compression
> rations, so I do the point in supporting some better alternative.  But
> can we settle on *one* gzip alternative, reducing the total number from
> seven to two?  Reasonable choice for the alternative would IMHO be:
> 
>   (1) xz - that seems to have established as *the* gzip alternative,
>       release tarballs are either .gz or .xz these days, everything
>       else is rather exotic.
> 
>   (2) zstd - typical distro kernels need that *anyway* because there
>       are more in-kernel users, btrfs uses zstd compression for example.
> 
> distro data points:  fedora/x64 used gzip in the past and uses zstd
> compression today.  fedora/aa64 uses gzip for zboot.
> 
> take care,
>   Gerd
> 


