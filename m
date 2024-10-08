Return-Path: <linux-efi+bounces-1922-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A76339947DC
	for <lists+linux-efi@lfdr.de>; Tue,  8 Oct 2024 14:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C951D1C24960
	for <lists+linux-efi@lfdr.de>; Tue,  8 Oct 2024 12:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7820A1CCB44;
	Tue,  8 Oct 2024 11:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+xcJE6K"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23761D8E01
	for <linux-efi@vger.kernel.org>; Tue,  8 Oct 2024 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728388793; cv=none; b=aFW3BtBiuw9p/U0d/1bdEDLE/5anLX+bxHdoHmj1r+UVE5LKTs58ZgindmMTZKttxwrIBtzA0QwDS1768lE9Gy6WZHNd4Lyj3URclXh6R6qFElqJ4AMb3zHim3H2JQMeTKU68r2nbEqsmGbJhN/fGTIxN/xI8AivZp4x8xR5+zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728388793; c=relaxed/simple;
	bh=ibSI5cw70YlzypkcFvottxsO6l9I+7EejtPji06w3+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arTSsb7r589RoYBEfT+KzSTPHmADQ4uKeE38CEFVC1O42k+PKUbkXoEUSQnoOS7X1FFJpzqCN/FiLfxTYlyQI0VsEoULiScqVD/k9LLuxNPGwd0irxTfVMV8LFq+SMlucRXbVrJvfelWSp7FkzoOKAoj5JbZqfWT478wS9O8FFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+xcJE6K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728388790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIFABVwlYN6z1gPY1Am/qwHJ+gGFXbVoWW3PcOPdoLQ=;
	b=Q+xcJE6KdIqwVj0zTk/sDNTIKs5sHNt4Ds25rP27jcckVN9ViWqSYVoav+9KU2A+0gl6FU
	4nnY+sadKF17zA3VEDIcYlfmRsVJC9m1pMU+cVo8WGBKy5FS4xpie1EVwPb3wbo9kbPlFa
	9b8G0p7m+Hy4JE7DvJWzDcIwipMgfiM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-2AuDJGkGPkKPoriTjj5KRA-1; Tue, 08 Oct 2024 07:59:48 -0400
X-MC-Unique: 2AuDJGkGPkKPoriTjj5KRA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6c513582b05so100288266d6.3
        for <linux-efi@vger.kernel.org>; Tue, 08 Oct 2024 04:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728388788; x=1728993588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIFABVwlYN6z1gPY1Am/qwHJ+gGFXbVoWW3PcOPdoLQ=;
        b=sa1qTgFQB4ZwJGsjumwfXLmhpegspeEs8FkX91RLIU3p8XbPmbuwc2riMMfUkHFiug
         DnXx2cXKRQFQcFFv6E5tb7sFWFAcW17RU3hYGyT3Pkav/fEfeXq6J9J8VHwjcC4ojq54
         p2ZZlmwYb6RlzAwJFDzfxTDdX6tNvvMrM28Birn9ekE2KPt8o2o8IGqLnxUMkxakvUcr
         f3PUsoaRQFFHtQuEUKRcbSAbIFsxKngyWPVTS1GK9EiOj93KOuVneggswo74KNuuu/A/
         O4ZduGK0SgtAWfDTzyhF9bYWHAMFIiqOIgKk1jF5YKhj3NPw+SkyeCgWvh7rqrvKXBXu
         ms2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsE7Bs28VSjMqiPv0iiei8gRyYttKyIm79+GoEqvsQDXXMktFbxa/kBv7xve0uFiEteD5TK+mEyj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAcLQgMyffXnb+rF4Ml+104JX3b9i0ekaYe29Fgu0waqMuCD5Q
	iE2LSCm+m4uXI2f9vWrFqKFpQV5COvOAzY6K8tt6m57OvKDwxuXUZFtaGb3tSiW70o0P8OLZGv1
	qfdcgJaYzOj8111GmDRZGs3IT3cmQ+bg4PDN8AvR9ZCmxCAxG52u4SCGl9FgAJhzQjPz3AkoQDW
	1ZYoyFOZ4Ch8TXENZz5ZpkOfRWa+bMm3R+
X-Received: by 2002:a05:6214:4341:b0:6cb:3d9e:4f0f with SMTP id 6a1803df08f44-6cb9a2ed6a6mr239302346d6.1.1728388788050;
        Tue, 08 Oct 2024 04:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyTU2oDPRA8pDwdxAwmkXFDkUDJtk+0gQ1yQnI6Iw1CeZllQSy0r3Wl4WVMcMUozYzPXRgfmAZg4oe2m9uSyE=
X-Received: by 2002:a05:6214:4341:b0:6cb:3d9e:4f0f with SMTP id
 6a1803df08f44-6cb9a2ed6a6mr239302016d6.1.1728388787608; Tue, 08 Oct 2024
 04:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
In-Reply-To: <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 8 Oct 2024 19:59:35 +0800
Message-ID: <CAF+s44RqwOXVQ_t=w922GAAdQAqx4H_EsccDmDd1h8qWAGvPBg@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Lennart Poettering <mzxreary@0pointer.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 1:08=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
[...]
>
> Thanks for putting this RFC together. This is useful work, and gives
> us food for thought and discussion.
>
> There are a few problems that become apparent when going through these ch=
anges.
>
> 1. Implementing UEFI entirely is intractable, and unnecessary.
> Implementing the subset of UEFI that is actually needed to boot Linux
> *is* tractable, though, but we need to work together to write this
> down somewhere.
>   - the EFI stub needs the boot services for the EFI memory map and
> the allocation routines
>   - GRUB needs block I/O
>   - systemd-stub/UKI needs file I/O to look for sidecars
>   - etc etc
>

I have created a git repo to hold the record for the current status.
[https://github.com/rhkdump/kexec_uefi.git]
And uefi_subset.md records the minimal requirement of uefi.

But I have a question about "GRUB needs block I/O", is it required? As
I know, the kernel image e.g. UKI, zboot will be supported. But why
should grub be supported too?

Thanks,

Pingfan

> I implemented a Rust 'efiloader' crate a while ago that encapsulates
> most of this (it can boot Linux/arm64 on QEMU and boot x86 via GRUB in
> user space **). Adding file I/O to this should be straight-forward -
> as Lennart points out, we only need the protocol, it doesn't need to
> be backed by an actual file system, it just needs to be able to expose
> other files in the right way.
>
> 2. Running the UEFI emulator on bare metal is not going to scale.
> Cloning UART driver code and MMU code etc is a can of worms that you
> want to leave closed. And as Lennart points out, there is other
> hardware (TPM) that needs to be accessible as well. Providing a
> separate set of drivers for all hardware that the EFI emulator may
> need to access is not a tractable problem either.
>
> The fix for this, as I see it, is to run the EFI emulator in user
> space, to the point where the payload calls ExitBootServices(). This
> will allow all I/O and memory protocol to be implemented trivially,
> using C library routines. I have a crude prototype** of this running
> to the point where ExitBootServices() is called (and then it crashes).
> The tricky yet interesting bit here is how we migrate a chunk of user
> space memory to the bare metal context that will be created by the
> kexec syscall later (in which the call to ExitBootServices() would
> return and proceed with the boot). But the principle is rather
> straight-forward, and would permit us, e.g., to kexec an OS installer
> too.
>
> 3. We need to figure out how to support TPM and PCRs in the context of
> kexec. This is a fundamental issue with verified boot, given that the
> kexec PCR state is necessarily different from the boot state, and so
> we cannot reuse the TPM directly if we want to pretend that we are
> doing an ordinary boot in kexec. The alternative is to leave the TPM
> in a state where the kexec kernel can access its sealed secrets, and
> mock up the TCG2 EFI protocols using a shim that sits between the TPM
> hardware (as the real TCG2 protocols will be long gone) and the EFI
> payload. But as I said, this is a fundamental issue, as the ability to
> pretend that a kexec boot is a pristine boot would mean that verified
> boot is broken.
>
>
> As future work, I'd like to propose to collaborate on some alignment
> regarding a UEFI baseline for Linux, i.e., the parts that we actually
> need to boot Linux.
>
> For this series in particular, I don't see a way forward where we
> adopt this approach, and carry all this code inside the kernel.
>
> Thanks.
> Ard.
>


