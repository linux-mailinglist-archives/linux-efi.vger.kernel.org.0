Return-Path: <linux-efi+bounces-5512-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEDFC5C475
	for <lists+linux-efi@lfdr.de>; Fri, 14 Nov 2025 10:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D28042149D
	for <lists+linux-efi@lfdr.de>; Fri, 14 Nov 2025 09:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ECA305E19;
	Fri, 14 Nov 2025 09:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdznabUl"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CFB304985
	for <linux-efi@vger.kernel.org>; Fri, 14 Nov 2025 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112377; cv=none; b=MGqx4Ap3xQVIYNYVZNhKeH+eXoAoRq3PUZnUDsTRJYuO3j0YaYx90QeXZt5fEBbObM8rKKDs6P8yqAjbWsnATmONCpPS+RfpvOWX4rNBSqwtFkvzXMXG3Q6eGyo++mcyIGud+qJEF2JX0+bArsaBY/Vd/9vNWmb4Xe+G2tNj09Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112377; c=relaxed/simple;
	bh=js4PA5bRCJWVaJiozlPfhPnR8+xdEJIPSZQez/38S70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/xV2Ezmgygs/YOhdjr0iqANw0C8MryYatauxY2dKow59A6vTyF8KL6uVTPB08lLNmB8rt47YXeC1XwpA0F5nzayBiebRvIxAbn5MdIOrDenRBaGpQeExBKJBSHvMzB6e7xvxIIGYG+AxDY0Pf6xoqg8iWx7HVIh2kyZjQIGLrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdznabUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52F1C2BC86
	for <linux-efi@vger.kernel.org>; Fri, 14 Nov 2025 09:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763112376;
	bh=js4PA5bRCJWVaJiozlPfhPnR8+xdEJIPSZQez/38S70=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QdznabUlT/StywBayjXvsvVLHQgGlheD4oYLACQPlAKcEWyDHmIOBF0d6rJsWvQYg
	 cXS1UdN72VyMhEa992f3xCe1/oKmhDLjeZXtXqkXQoorF0ZBh6t1Tj1g9Nq2cvPTqJ
	 5Ib3wp47AVPo+lFJ3l8Bx+Vu/lhd+mlYrWWyAXx0Hiyys0toe7x13YRNDkCVYE57wY
	 69VBCyK5hB1AWBnPsz8ArX55bpDxaqsIJMn8+pxlGapxODdi0fzGdIPjOiCVAedVS3
	 Cu0sbRNkT71sr3sDFcfmq2cDXUsiuRcDGMCCcXDZoLsjpJf5GQxE2OlitnzxzZ6g3q
	 4ypK9qeVx053A==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59445ee9738so1303959e87.3
        for <linux-efi@vger.kernel.org>; Fri, 14 Nov 2025 01:26:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXsBMpzPMfWHbhfHvgOMB4nlqN8oimoCZUGsbRQ7Ppovkrq28xXSG4bL/1/xIctz/gOvNbQL3olLqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXXkk7E042VDYstWv3tVbcotjjpql/vYm4wEWw+KF7LU2CPnkU
	1/4T7/dUVCepyC/jfZd9rCbo5J3n78iOy5Jkna9b261TNY3skh6lcjTJNAgEYnGVJ4l2fe3HJA3
	8CXQmQ3c0vZN6u9UGX64hwX0Xqb3oqxw=
X-Google-Smtp-Source: AGHT+IF3tFmwAcyyqBFAGn65NZXYkgHv33xvrkudgQL42Yr2p2jyMiQqIYBJjDBFA4Hy8YCD1Q4u+g7Fy/whFgTICHY=
X-Received: by 2002:a05:6512:239d:b0:595:7ed0:9c7e with SMTP id
 2adb3069b0e04-595841a8136mr801860e87.3.1763112374934; Fri, 14 Nov 2025
 01:26:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114085058.2195900-1-sumit.garg@kernel.org> <20251114085058.2195900-3-sumit.garg@kernel.org>
In-Reply-To: <20251114085058.2195900-3-sumit.garg@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 14 Nov 2025 10:26:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE4Fo3i9f3npB0MBSOZP0x7HgF4A0KX_aUSBEBmar=NpA@mail.gmail.com>
X-Gm-Features: AWmQ_bkj4pWjMOHYgOZPEajb9wd6GCv0LCKBd1STFSWl45rYWURYaKvi9YfNTsw
Message-ID: <CAMj1kXE4Fo3i9f3npB0MBSOZP0x7HgF4A0KX_aUSBEBmar=NpA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: efi: Pass reboot cmd parameter to efi_reboot()
To: Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, andersson@kernel.org, konradybcio@kernel.org, 
	dmitry.baryshkov@oss.qualcomm.com, shivendra.pratap@oss.qualcomm.com, 
	leif.lindholm@oss.qualcomm.com, linux-kernel@vger.kernel.org, 
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Nov 2025 at 09:51, Sumit Garg <sumit.garg@kernel.org> wrote:
>
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>
> EFI ResetSystem runtime service allows for platform specific reset type
> allowing the OS to pass reset data for the UEFI implementation to take
> corresponding action. So lets pass the reboot cmd parameter for the EFI
> driver to determine whether it's a platform specific reset requested or
> not.
>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  arch/arm64/kernel/process.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index fba7ca102a8c..51784986c568 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -136,7 +136,7 @@ void machine_restart(char *cmd)
>          * ResetSystem().
>          */
>         if (efi_enabled(EFI_RUNTIME_SERVICES))
> -               efi_reboot(reboot_mode, NULL);
> +               efi_reboot(reboot_mode, cmd);
>

I agree with the general principle. However, there are already
existing callers of kernel_restart() that would end up passing a
random string to efi_reboot(), resulting in platform specific reset
with undefined result.

E.g.,

$ git grep kernel_restart\(\"
drivers/md/dm-verity-target.c:          kernel_restart("dm-verity
device corrupted");
drivers/md/dm-verity-target.c:  kernel_restart("dm-verity device has
I/O error");
drivers/memory/emif.c:                  kernel_restart("SDRAM
Over-temp Emergency restart");


>         /* Now call the architecture specific reboot code. */
>         do_kernel_restart(cmd);
> --
> 2.48.1
>

