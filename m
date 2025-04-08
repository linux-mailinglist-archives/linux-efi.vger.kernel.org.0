Return-Path: <linux-efi+bounces-3243-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94C3A8145F
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 20:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D0A4C14CF
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 18:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70A822D7B4;
	Tue,  8 Apr 2025 18:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Piv55oZL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3293C22D784;
	Tue,  8 Apr 2025 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744136209; cv=none; b=qUut6fsPGOMoTep7FgXzEKsEXvx6baPhHwFAN84GCIZtb7V2wwBOzJV2FQ/HBOxnBFnZDoK+Y4zaip+pOu9qDiEai/ulH7/NQ1hb5yfqVq3FpXxcUu47n8gfzloIY9PzbyFK10PhZ020nu4gKyYuCml5ueIE3aFju5DgW0h5ZwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744136209; c=relaxed/simple;
	bh=GVBUGj5lwlgDtnpbMzm7AEU7QmUuIZeQl9ia/W0jObQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzbFLArCOizodB8wptIUGW2G21l8Yht+KVXke6IbkkwG205lAteyckgrkWjCgD1TLPLkSFBTVPVCTbxOzKENicMRzC1slgogVDa4D8h4gf2kVKvpK9E5NDFdsQqHOzFWLRQgulBpwOBy50/WrEiOR7KrVOcaH+hfQ9jkg/2883c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Piv55oZL; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54af20849adso5762227e87.1;
        Tue, 08 Apr 2025 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744136206; x=1744741006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpi1lL06DMBKX7u3P6QnOCCZJvFffjMjWuVsvjpjjuk=;
        b=Piv55oZLg97rFt9mMss8NHWJicFwMuj/sA6O78NG2N8Cl+cBABbPMaqC6HEJqauNHs
         omnyb2aNs3otTi+A2DT//M31VH/P8DxMEjT1sJ9uyj5rkVTQpm9uM5nSdStFacNUIpT/
         o4BxFdIlRo59XTa24kwTn6lpV885eG1EjfBvsnGjbOlfM1McUK0ICb0vFH/kTisPW9O5
         nMgY1/XnbDo7n29mJHChfuYJRBzeFMRFSpWSJ96K9r/1Q2Crh0XBtBm0hANayQgVtfKi
         GwPdAYXSnFVwF7NZeSlCRT5d4MvAZQswOiqhUpz5ZHLrcupEdhSEqQtwcxzK2tSTNIw2
         MhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744136206; x=1744741006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpi1lL06DMBKX7u3P6QnOCCZJvFffjMjWuVsvjpjjuk=;
        b=QM9B1N2viTne6uhFMWdoZ4E0y6oaR88O2jr2Wu8SKqrPW0SqiWNJ2lkMCsnEbm3xrR
         83281WJaa4RHVlWCXQYmUFSBRrKPLJwoZs4i57G7cYlJ7BRhdRz3QFJb0ejdIoRS6PKX
         5F5/hHPFVg3I8KpWJSZPNMX75EtukDsY/q/Dth01SU236Xe8uXN0VNA33mwCQi8N/J1p
         NCnWH0bamSkZK1X5FDLJwz2L2rAAhlqV4ARSCtiX+tqBNxeVYSIF1ero2/Tc8zd0pgXx
         XftiYtxgSj5Ny2owGetfrcTa6WPK0dgqKftOpXI7mAcpQwBOTxo0VZL3fMklz/PZDk+d
         16RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWB6lbuphtA/T8iPvKbze+3cKyb6j506vTjbfVJ2WPHAD43gB8GGRuQ48Iz/ENMZ6gTeHrz6vLlaLF8+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy66eL5QKzxZ3XnZCIf6i8diBXLsG9+6a5baWKJwP/5cCyIC8iL
	PmfTqvHzVh35U/Q7bv4cEv/Di4E897Jx4JnKhtxLOjJZ3I+6lVZhGyIKiEPpeyRpxJwRvQc1QxB
	kc0JBuhMCPFijh7dvP/WtZdY7XQ==
X-Gm-Gg: ASbGnctDzm/hj4pMH66NDxLDtiI/y4UPoOfTu3TRbLFNI8oy79aq8FLGcEnEqnjWoYj
	L2WyxdWpwD6BCWHL+ukQ4MOoJrHdVLBaTMONX4CBKqiTgNsOpJhpQuTCTBkbXyXnRIJykI3nGah
	mJeibB8u5J33qYQg3Ek+MVKrRnbxaqXMiPiBCNhPpH
X-Google-Smtp-Source: AGHT+IG8EgpkREr52a3nFSH8verF//aFoA/rAOhBA+3f8s3RF4sM0OuOt+dW733YHCkn44l+gvCwj8bgtDd3a0Pf2cY=
X-Received: by 2002:a05:6512:3ba2:b0:54b:117f:686e with SMTP id
 2adb3069b0e04-54c4373178emr5830e87.27.1744136205955; Tue, 08 Apr 2025
 11:16:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408085254.836788-9-ardb+git@google.com>
In-Reply-To: <20250408085254.836788-9-ardb+git@google.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Tue, 8 Apr 2025 14:16:33 -0400
X-Gm-Features: ATxdqUEMrbI5BDwK_MC2ArLzFA7fiMI5V7jE2Ot7amcKuprTIJn6ipW8Wb3nrjY
Message-ID: <CAMzpN2hrmNhiT8Ppb_fSGW2XtCDY1aiR=2x6Fcv2gzD87r-Akg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] x86: Refactor and consolidate startup code
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, x86@kernel.org, mingo@kernel.org, 
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 5:01=E2=80=AFAM Ard Biesheuvel <ardb+git@google.com>=
 wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Reorganize C code that is used during early boot, either in the
> decompressor/EFI stub or the kernel proper, but before the kernel
> virtual mapping is up.
>
> v3:
> - keep rip_rel_ptr() around in PIC code - sadly, it is still needed in
>   some cases
> - remove RIP_REL_REF() uses in separate patches
> - keep __head annotations for now, they will all be removed later
> - disable objtool validation for library objects (i.e., pieces that are
>   not linked into vmlinux)
>
> I will follow up with a series that gets rid of .head.text altogether,
> as it will no longer be needed at all once the startup code is checked
> for absolute relocations.
>
> The SEV startup code needs to be moved first, though, and this is a bit
> more complicated, so I will decouple that effort from this series, also
> because there is a known issue that needs to be fixed first related to
> memory acceptance from the EFI stub.

Is there anything to verify that the compiler doesn't do something
unexpected with PIC code generation like create GOT references?


Brian Gerst

