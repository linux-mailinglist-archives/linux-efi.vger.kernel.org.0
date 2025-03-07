Return-Path: <linux-efi+bounces-2919-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0395A568F7
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 14:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFC53B7F31
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 13:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8086620E00D;
	Fri,  7 Mar 2025 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQ/CitKq"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD99421A42D
	for <linux-efi@vger.kernel.org>; Fri,  7 Mar 2025 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354149; cv=none; b=Xk4AjUygJa+ebtFpiSnOCBvuHOZtZyONcyCT0A2ls8T6y8IUfLfJ/jvKCeHmIfHI1K+fHApZPW2qoK5hmtPpGPhIQ/WkjV61mOkmT0OSR5V3+74KIsc6h03i8HKh3lX8+Aej5MfdMbrfVPCTtGA1niP4kKj74gxUQQlrssWCJ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354149; c=relaxed/simple;
	bh=9nKuMtvsWU1TrVzCAwkyWWp7A7SBIJ6ypr3UJ1tl9IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tR9/6RvoFUJFEIu8z39smrW2Ee0ok+NYWNBMBPQMuUMwqAkOETrk4D7Wvj6VVk3Osd9y42SOpGCgIPyOjG7FNiWfZ5DUVgVZjE1eJrWN8kfIkl04UoNY6s8Z9W6wGwP5IdGqsBRuJlO9PbWje8L+IxvjDhExdTIiMDAoYmbimCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AQ/CitKq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741354146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wJGRk7CHK3UN5zhTn0td6dI9HKw2eovpPE/rDXeu+UA=;
	b=AQ/CitKqexT6k2rJ5rDtOjYgxVmnm1tya+HVXCPdfo0eKW/e0L9OrWXYmzeo0d1MwOzVhy
	TXT2vioLR972SpIKDKAD9qfFO/T/Bh5R4QKi2kqWS7RBq8fkZCtGcaK7TFJ8eQkCAEWRM6
	SlcP+m3o0+rZ7apdiJZkleE5a7d0oPM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-2Wa5Ky9DN8ChuBA_Tlzgfw-1; Fri,
 07 Mar 2025 08:29:03 -0500
X-MC-Unique: 2Wa5Ky9DN8ChuBA_Tlzgfw-1
X-Mimecast-MFC-AGG-ID: 2Wa5Ky9DN8ChuBA_Tlzgfw_1741354142
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C1F51955DCD;
	Fri,  7 Mar 2025 13:29:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.122])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B81E1954B33;
	Fri,  7 Mar 2025 13:28:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id E8E6D1800091; Fri, 07 Mar 2025 14:28:55 +0100 (CET)
Date: Fri, 7 Mar 2025 14:28:55 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org, 
	linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Jones <pjones@redhat.com>, 
	Daniel Berrange <berrange@redhat.com>, Emanuele Giuseppe Esposito <eesposit@redhat.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Luca Boccassi <bluca@debian.org>, 
	Peter Zijlstra <peterz@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] x86/efi: Add a mechanism for embedding SBAT section
Message-ID: <63vy4xc4mpm5tttdqz5vfzwyriqlminjdiffrbuamxcubmpuur@nxszi7xzxa6a>
References: <20250305101744.1706803-1-vkuznets@redhat.com>
 <CAMj1kXF-c46Bdw_cmLK-TckxukefqkpAYkOhg3jzfvW6YucDog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF-c46Bdw_cmLK-TckxukefqkpAYkOhg3jzfvW6YucDog@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

  Hi,

> > This patch suggests a different approach: instead of defining SBAT
> > information, provide a mechanism for downstream kernel builders (distros)
> > to include their own SBAT data.
> 
> Why does this require a mechanism in the upstream kernel at all?

To avoid every distro re-inventing the wheel?

> > - CRC32 must be at the end of the file.
> 
> We never cared about the CRC32 before with signed EFI images, which
> gets clobbered when the image is signed. Why should we start caring
> about it now?

I have some blurry memories on having seen this crc32 discussion
before ...

The crc32 is not clobbered.  The signature is simply appended and
wouldn't overwrite the crc32.  But if software expects to find that
crc32 in the last four bytes of the file then yes, that assumption does
not hold any more for signed kernel binaries.

Who uses that crc32 and how?  If it is useless anyway, can we just drop
it upstream?

> Please don't create a special case for x86 again - iff this needs to
> be in upstream (which I am not convinced about) it needs to be
> implemented for all architectures.

Well, x86 *is* the special case.  Everybody else just uses zboot.

But, yes, when this RfC patch discussion comes to the conclusion that
this is useful to have upstream the plan is to do this for zboot too
so all architectures are covered.

> So I'd like to understand better what is preventing you from appending
> a PE/COFF section on an arbitrary bzImage (or EFI zboot image).

Well, assuming it is safe to ignore the crc32 as per above discussion
then nothing really.  It should be possible to do this as part of the
signing process instead.  That leaves the "not re-inventing the wheel"
aspect of this on the table.

take care,
  Gerd


