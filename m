Return-Path: <linux-efi+bounces-1953-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C20699B6D0
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 21:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C00A1C20FB0
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 19:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C503715B0EE;
	Sat, 12 Oct 2024 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIxrXlY6"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CAB13D2B8;
	Sat, 12 Oct 2024 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728762429; cv=none; b=K5FIxrjyYJVmSgI3TIyiCzxfDG/jhREpx4T0JSBxWd2Zxk0tw5PIzKxYhH0X8Ow0D0aHTucl37Wf140ZxzwSjKPqHeRNJbToYPHPzto4DQVyJuCOqoPRnFWZWJlPRgoNHlGtBu9+jpFIkp9KtS9d2lp5QRTuOZCkZ5C1rBUY3xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728762429; c=relaxed/simple;
	bh=6fXoloa0PbYTnHdAlrFm+tBCeNR04ViA9fnunm9h0us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cuQqr9DSfi7+oGQMiBPXwhiIkTceQtHi3tCteyfVOX237DuAHg6DGg31m7jOu1j8L8O56ahjj/9D/XXaBzaSUfXJHwbbLnNaywzjn1uwq0Y2yfOfoR1O3PsMJ33VBF1iwPSEsY5257OcVTDO8VCEMfG5IRUXc5V/ja/CNf+tS8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIxrXlY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38AD3C4CED0;
	Sat, 12 Oct 2024 19:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728762429;
	bh=6fXoloa0PbYTnHdAlrFm+tBCeNR04ViA9fnunm9h0us=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RIxrXlY6uF7mKqEv/iVwqMpP+9RVR+95qeVIdlDjg22QlLGZ6ElfxVag4yuuGIA77
	 fIxC1WmtOghxnK1oHwIJOZywXFO/T0MQ4XTBF+ZvlbEE1exAlgcVri2IaahpPapve4
	 rZA5QOjd+R6SMjAp3qAE10b6B3NXErtsTW4PJNqKN3HaQvcmwLQnWfYBMFd0i4dWAr
	 2PWhGyX0ti5NilwE+ipfbqMiBSw+P/RDLsXsPvk96rBm8Me4XaSTtWCY4NAq8habGj
	 xnPgdtOJi5r3iulruzDdRrfi8qhlvpjML8qCJtCAblzQToFJlHA1hO/aflyno4tyuh
	 0vtgApeLonzdw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e044d32bso1957619e87.0;
        Sat, 12 Oct 2024 12:47:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDV5HHhYTbb9LRjfEde/L/iiPh/AfRIDtrP/FFWsE9WFDAxurv6fIu6n6zn2Qjk3Vf0XyqSjp5cJYq8yLs@vger.kernel.org, AJvYcCX5KRTiiTV8a287RpWNBAQ5j0Ed/VSH37JYv8lye2vWgdrGJN2EV+PQTYuH7EB2C+4eq16LHkAR+SY6@vger.kernel.org, AJvYcCXAVwfo4IO8b68DzFAxF1voxmY8WZr7LLWJfhdYNx7gptF7nllqILbNTM+JEFslqVr9W/ALks35r2jP@vger.kernel.org
X-Gm-Message-State: AOJu0YyrS9+8/Q46KhcT+CJSWfJ1UktwFUjmDnOoKGubTT2qHk6i2cJY
	BTKsbElriaL4g7BQu5c0yW+NxqBmBXh69CWeJ/j/rz6TntFBdWB/exgRVThOB5pWLSgMGfZhsbN
	3YhMPLb0ldmsZTAoXxRU+kt9aXOA=
X-Google-Smtp-Source: AGHT+IHMsQXAt4q5lcrN8yEZZ7V0+Wjozers93eRalkrtxJFTSt6H+H69nM6ce0+g7ukiaDJT85ZzEw0WJUAe8qUJzk=
X-Received: by 2002:a05:6512:b9c:b0:539:e817:967f with SMTP id
 2adb3069b0e04-539e817a374mr686282e87.19.1728762427545; Sat, 12 Oct 2024
 12:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012194210.3588557-1-kobak@nvidia.com>
In-Reply-To: <20241012194210.3588557-1-kobak@nvidia.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 12 Oct 2024 21:46:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH6Q2t6ER3kZDtiAFmk6QKj24_LtV9gjfq3bjQCBAVSww@mail.gmail.com>
Message-ID: <CAMj1kXH6Q2t6ER3kZDtiAFmk6QKj24_LtV9gjfq3bjQCBAVSww@mail.gmail.com>
Subject: Re: [PATCH V9] acpi/prmt: find block with specific type
To: KobaK <kobak@nvidia.com>
Cc: Matt Ochs <mochs@nvidia.com>, James Morse <james.morse@arm.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Oct 2024 at 21:42, KobaK <kobak@nvidia.com> wrote:
>
> From: Koba Ko <kobak@nvidia.com>
>
> PRMT needs to find the correct type of block to
> translate the PA-VA mapping for EFI runtime services.
>
> The issue arises because the PRMT is finding a block of
> type EFI_CONVENTIONAL_MEMORY, which is not appropriate for
> runtime services as described in Section 2.2.2 (Runtime
> Services) of the UEFI Specification [1]. Since the PRM handler is
> a type of runtime service, this causes an exception
> when the PRM handler is called.
>
>     [Firmware Bug]: Unable to handle paging request in EFI runtime service
>     WARNING: CPU: 22 PID: 4330 at drivers/firmware/efi/runtime-wrappers.c:341
>         __efi_queue_work+0x11c/0x170
>     Call trace:
>
> Find a block with specific type to fix this.
> PRMT find a block with EFI_MEMORY_RUNTIME for PRM handler and PRM context.
> If no suitable block is found, a warning message will be prompted
> but the procedure continues to manage the next PRM handler.
> However, if the PRM handler is actually called without proper allocation,
> it would result in a failure during error handling.
>
> By using the correct memory types for runtime services,
> ensure that the PRM handler and the context are
> properly mapped in the virtual address space during runtime,
> preventing the paging request error.
>
> The issue is really that only memory that has been remapped for
> runtime by the firmware can be used by the PRM handler, and so the
> region needs to have the EFI_MEMORY_RUNTIME attribute.
>
> [1] https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
> Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler for the PlatformRtMechanism subtype")
> cc: stable@vger.kernel.org
> Signed-off-by: Koba Ko <kobak@nvidia.com>
> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> V2:
> 1. format the changelog and add more about error handling.
> 2. replace goto
> V3: Warn if parts of handler are missed during va-pa translating.
> V4: Fix the 0day
> V5: Fix typo and pr_warn warning
> V6: use EFI_MOMOERY_RUNTIME to find block and split goto refactor as a single
> patch
> V7:
> 1. refine the codes and commit description as per comments
> 2. drop goto refacotr
> V8: Fix 0day and cc to stable
> V9: Describe 0day fix
> cast PA as (void *) in pr_warn

Sigh.

Please read to the end of my previous email and fix the other thing too.

