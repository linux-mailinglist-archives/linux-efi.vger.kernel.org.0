Return-Path: <linux-efi+bounces-2320-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 956C09E895A
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 03:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F38163593
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 02:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76B81C28E;
	Mon,  9 Dec 2024 02:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DyKCmR0X"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055DE4C91
	for <linux-efi@vger.kernel.org>; Mon,  9 Dec 2024 02:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733712441; cv=none; b=I6Ph8qiP/tDz0YT+nzNQYQUp2MYOhr5vWgR/JsKkLbQGr64LDKJik/GO4C7HMy6NsOGbw5J6AQrEzsb66ByhrBKkwI12e4PPsPHKYnVCyrFSDMrm2RupVANFeGIX5uX+uI91TEwhtItgiir8uAl8eSAWRn89MwbYB47auYQ1+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733712441; c=relaxed/simple;
	bh=CpwHVcHS2iXzQe+xy2O2yAOdeRUd12i7ffLAr7Hwrj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnG/WO0TepMrqcEbhcfzL/W7dTswoqzcFZUxmYKh6af6gUxa/4Ut/TPUKZYRmd2aFI8k2qHJUUSSXYnQq3tRrycIkt3PAEQWwYOPG/1yJQ7ExmmoKEIQ+piEkWtxUx4W1nrJnZbg1TtbMxERyNTq3Ux8pvdMRllmf92JPucAagk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DyKCmR0X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733712439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bU8S5e406R7aWO3RRyuQUoErXuoSCwc2cREjDhNAD6k=;
	b=DyKCmR0XfDGI9nWLffzGm5+feUq8AfPE6dZr+cr5VcDgKKzhfZmv/sGc9ifCgnK6r2Kv+M
	hZn1R9539SOABEw7sIxOzjQml55J6vp/9nLj9NviVHR3OCcG49CULFCLxxRVBh/T10cB6r
	1Wa/4IY2jU1KtQb9EoYwReoO5fqfjx8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-HfkUkQLPPSql1A_ZrDSRag-1; Sun,
 08 Dec 2024 21:47:15 -0500
X-MC-Unique: HfkUkQLPPSql1A_ZrDSRag-1
X-Mimecast-MFC-AGG-ID: HfkUkQLPPSql1A_ZrDSRag
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2025C19560A2;
	Mon,  9 Dec 2024 02:47:14 +0000 (UTC)
Received: from localhost (unknown [10.72.112.98])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A73231956056;
	Mon,  9 Dec 2024 02:47:12 +0000 (UTC)
Date: Mon, 9 Dec 2024 10:47:09 +0800
From: Pingfan Liu <piliu@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Peter Jones <pjones@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	linux-efi@vger.kernel.org, Will Deacon <will@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Philipp Rudo <prudo@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH 1/2] Makefile.zboot: Sign Image before packing into
 EFI-STUB shell
Message-ID: <Z1ZaLbZFm9OPRbQi@fedora>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Dec 06, 2024 at 09:03:30AM +0100, Ard Biesheuvel wrote:

Also cc Jan, Philipp, who are also engaged in related topic (UKI)

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
> >
> 
> The whole point of the EFI zboot format was avoiding the need to sign
> the compressed payload.
> 
> Now, we are back to signing the payload along with the full image
> using PE based tools, even though the payload is intended to be booted
> as a raw image.
> 

I remember that I sent out a zboot image parser in the kernel to tackle
with this signature issue.  But that will complicate the kernel image
parser, as a result, we defer resolving it, and finally we have it
implemented in the user space kexec-tools.

The emergence of UKI makes things more complicated. Jan introduced "UKI
format parser in linux kernel". For arm64, the UKI support in kernel
means that a UKI format parser should be followed by a zboot format
parser. 

So we tried emulator solution instead of parser. ( I have a summary on:
https://github.com/rhkdump/kexec_uefi/blob/main/overview.md)

But either of the emulator methods have their own drawback:
	-1.the purgatory-style method has trouble in the hardware scaling.
	-2.the user space emulator can not ensure the security. (also I
           think it can not resolve the hardware issue since at that time,
           it can not alter the hardware status arbitrarily)


> I'm not sure I see the point of this: EFI zboot is a trivial container
> format which records the compression type and the start and length of
> the payload in its header at a known offset.
> 
> Perhaps we should just make EFI zboot gzip-only, rather than
> supporting 7 different compression methods because that is what the
> legacy decompressors on ARM and x86 support - I struggle to see the
> point of that tbh (even though I implemented that myself)
> 
> That way, the kernel can authenticate the outer PE zboot image as
> usual, and perform the decompression itself, without having to carry
> code for all compression formats it might encounter.
> 

It is always good to keep things simple. But this seems helpless to step
around the kexec_file_load issue.

> (Apologies if we are sending you in circles, but if we get this wrong
> now, we're stuck with another kexec-related maintenance nightmare so I
> really don't want to commit to something tooo hastily)
> 

Although this issue has come full circle, we now have a clear
understanding of its solutions' limitations, advantages, and disadvantages.

Unlike the forecast of this issue about three years ago, we are now
facing real customer pressure.


Thanks,

Pingfan


> -- 
> Ard.


