Return-Path: <linux-efi+bounces-2774-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DECA2E9BE
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 11:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D26C7A2D43
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 10:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59601C68A6;
	Mon, 10 Feb 2025 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRCe1inX"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8693C15624D;
	Mon, 10 Feb 2025 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739184062; cv=none; b=hmJXoSYVghUppzptI2W6efz7ufiISKxS0UCcrPd9Saec+rt9o0FhbyCvP2dm0UQrEiTKwWRDvjbfdW4wtzuQqgGFQr/Kc5CfLPmrTBqhCdZDeePqT6tObYfpswRxoTcj8s+f5IfN74yB2dFjDEqGGxngOCUNCYD0h4rfWJeYZ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739184062; c=relaxed/simple;
	bh=46Hwj6oLN+R1cwvlaCePhHYl4MUD2RaTfTlAeH28PD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXekxyj3ZyoReLNNz5K4uJN6O4yxVVw/MASxmERKE8KVYC1AtN0fOeldMrtkGiyJRhzW8C+TJE9tVua0t1U8+/eXp3l/TvokSnhRbBnUCWJHqym4+qGuxq8wRAVoDt2HqauHW8Q41uKpOChQIvElpWx0wjsFojXyfjbt3VOqvog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRCe1inX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A280C4CEE5;
	Mon, 10 Feb 2025 10:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739184062;
	bh=46Hwj6oLN+R1cwvlaCePhHYl4MUD2RaTfTlAeH28PD0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KRCe1inXBHwlqKS3Hh9AwTu1SrsC48JkSvKv5sbuqf3ya3dfsgMn2XX8M+3DmSx0u
	 vb1o18WYjf+pNY9TyJ/GC+qMVq6Ui0ji/dMPCd0gqOC4OnR6LDSCxcWdLO57thijW9
	 mIHYjbhAIgcsrJn7xLC+vg+oCMIZVzhfp7m/DbM0bKS9p1tSiKSXc63+iTDLmRJrkp
	 Y0z6B3D/ScC6b2AeUav29rIgDIBa2gMq5arEzBpDia13FwgxkTSNcKZG+ocVo0PaXQ
	 tk6RNes1X/dCaEe+O5WVyv87wzj4RD4r51OFOhaoSEnOVtH0371uM6nrKeSCRcCDF3
	 z/an5nfH1RKwA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5450475df18so1955525e87.2;
        Mon, 10 Feb 2025 02:41:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCULVSZGkdsPddgW789YLsa4lFXIT3akEJoCcgGSSoZv8qVsMFVvTWHbgBW6897F3y54/30zQdIUW7ZX@vger.kernel.org, AJvYcCWvWZMXiHfA+QBG8RyNQIqDbOPA0PS7FIYipMVJ8plLeszP4T6zjlCyLu0zcLTOdCoH32rgbhaM8HwdPC8E@vger.kernel.org, AJvYcCXB+v/ZuG51yvRxqS00GlHIvFP5Bri2aehpqbZzc3hnR+E43QlrcxzfPqgbZsYQdF1ne4HhqeZSIPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3RdnDl3ekQTFB3AtiJiBzuY5WFoYh1JbAAptlWlEqsZJGUEmK
	nhRFiD8ixC+uRZtBbZ+xSydnm4F2eGmWNH10uM3WD7Zy6nfe29nYnUdrPMSVYa0kgxOCWLtvIzh
	LpXs3XxD0y7rPIkk0wT1c9PdpmEk=
X-Google-Smtp-Source: AGHT+IHmiCv54Xo/cZjV5WAg7h9ZUmfSozvF5UDhkh0PZYTf3WaMDplUz0RbzsrnJh8sZt+Ej2zn4srkEC9cpNCmkhM=
X-Received: by 2002:a05:6512:3d23:b0:545:bb6:8e32 with SMTP id
 2adb3069b0e04-5450bb68e9cmr1031982e87.12.1739184060357; Mon, 10 Feb 2025
 02:41:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241228202212.89069-1-lleyton@fyralabs.com> <4564637B-36D5-408D-B0CA-816D9F3466E4@live.com>
In-Reply-To: <4564637B-36D5-408D-B0CA-816D9F3466E4@live.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 10 Feb 2025 11:40:47 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFdm-3+zFejU+=78R5P80e9SiB9Tr-8W-zLjub5njL3sg@mail.gmail.com>
X-Gm-Features: AWEUYZnjz-PqgrefGcpuY2s6Ug1CVIXkiXnCGrBIrHsAhDDG3EJZjJjtCSU2XTA
Message-ID: <CAMj1kXFdm-3+zFejU+=78R5P80e9SiB9Tr-8W-zLjub5njL3sg@mail.gmail.com>
Subject: Re: [PATCH] x86/efistub: Add options for forcing Apple set_os protocol
To: Aditya Garg <gargaditya08@live.com>
Cc: Lleyton Gray <lleyton@fyralabs.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Huth <thuth@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Xiongwei Song <xiongwei.song@windriver.com>, Jeremy Linton <jeremy.linton@arm.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Jonathan Marek <jonathan@marek.ca>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Kees Cook <kees@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"

Hi Aditya,

On Sun, 9 Feb 2025 at 17:13, Aditya Garg <gargaditya08@live.com> wrote:
>
> Hi all
>

Please don't top post.

> I managed to get feedbacks regarding eGPUs on older non T2 MacBooks, and can confirm that apple-set-os is needed there as well.
>

This is rather vague. Where did you get this feedback, and what
systems does it cover?

Also, this is not about being able to switch to the integrated GPU to
drive the built-in panel, but for driving an external GPU connected to
a different screen altogether. AIUI, this has never worked on these
systems, right? So why is this important now, for 10 year old
Macbooks?

> I was wondering if we can reach a conclusion for this case here.
>

I'd prefer to address this in a different way: instead of fixing this
in the Linux kernel for the handful of systems that need this (and
that will upgrade to v6.15 or later to get this fix), why not use a
separate boot-time EFI app to call the protocol. That way, it works
with existing kernels too, and no changes are needed to Linux.

https://paste.debian.net/1349311/

