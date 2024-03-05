Return-Path: <linux-efi+bounces-723-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C54687261E
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 19:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED051C26073
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 18:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9533317BAF;
	Tue,  5 Mar 2024 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yXZlXGAl"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E88A16427
	for <linux-efi@vger.kernel.org>; Tue,  5 Mar 2024 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661695; cv=none; b=Mkq9ksuJwg2COMLTrYNWk3f1/HpJE8QF4xaujRMjp+FDlDExleSsP8UeFwMiVvocRhVpRVzOqAB6uIu6941dwe7YnSQj9+PVFM2qejhLQSys6cTkkxW+xWxr61XbxnfPQ9N+nycPagsRUPIqYvXq3oZRf538dwsWAJKw9xa0KQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661695; c=relaxed/simple;
	bh=JxsWIpYhrw0yj+dOcxVkY9nDuIgkArCAusybNAVXdNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vv+X5vNc8Y58JWemRZNBZj3tYTe3+3GKZeHSAXlMBr/xX0IevIa9zP6dV+FNJLmgZsvpuhCQ/va9u5/XiGoWGek8K6V0rMm4C8p4H3PDs06V+kc77npuQozuuikTceGQJpMU+U1PinMU0pGinXIlsuDp6JiuWAl63PqzD7zVjPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yXZlXGAl; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d288bac3caso73627761fa.2
        for <linux-efi@vger.kernel.org>; Tue, 05 Mar 2024 10:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709661691; x=1710266491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1qUyyr1xe58n5fPwCACgS+V9qMPtqxEaQMrQxOS+5Y8=;
        b=yXZlXGAlC7dnH3CLwL4BZD69lBm+7Hgy0UeIqPxQYfEfDKGZTQGcjHpVcZO3l33YsE
         XCJf68OlGjBuWE6tH8RJuHV/XVHgrm8BFO/vyxFBvnqcD4kkf0Rod0I4Axhogn8DoNMT
         tNawMuCjn1E8K1LCoE6d0RZgHMPyPEsy5tev584qDdVqBdO2v2w6Xc7K1EN68e+zE4+6
         shHuw+jQjc6OS/gPOjPDMzmLYV5YCuSbxraoTAxT13/+v6Im00FWbVaNKzO9eH5w2QZA
         Ev0V0CwSb1Eyj81yylSaiVlXoIMqJ3o6BB49E3JfAUu2GQa6GyWNbWQSQcYJZsF1zM5x
         qMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709661691; x=1710266491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qUyyr1xe58n5fPwCACgS+V9qMPtqxEaQMrQxOS+5Y8=;
        b=g8cIpT9OCHFXFMSp4BgRTZvsSO9dfWFTFqD/zZbzeWjCxrDcmL2nZ7J5SVs74S8SbI
         So7cWdWHhk1xzgqLUKCgt3GUNIxKL3/bWykeUql9Y66bt7QjAOM35hoVyCEktpxl7dLl
         3GzUSHwTisq823j2zvC56aYc2jycClR3Z5EUcrTYdsd7xH5nSAEV1og+4VJYD+f0Ksx7
         w1O0YH8eKBC+RajbMwwFVqHWUoluE9ErsBV0lzfebLhC3OJEajmkknNaFmeQz58qYraU
         wqx8inmwq7giOzwVnCwx8YZFSFW6md14HQVNR2oXJHpBwtrzCmclUlsCGaZL/YLCM3BX
         6Mwg==
X-Gm-Message-State: AOJu0YzzIk1Fp9kBHG7h8FtmED5rxYKWk1rzm/DndfarG5WKiyJhkD2s
	l7D2zP0EI/Lsp9gSjPa0ZYwexL+isU779W1vJHQKpWLXA9Oy5wHhzYTfuPsqkbbCnLNrvFrnaC+
	Wbk55B5xTT+bWVVL7d7t7ks2fmPoqCKua3XB4GQ==
X-Google-Smtp-Source: AGHT+IHat9OjxAwjLByJ9gwYG4Q/i4r/04aB4CwoTwj1I2uNEu9Jpe2msY+1pU0jH+dLyvhVTDaUCv050bmHXxOLi8g=
X-Received: by 2002:ac2:59cd:0:b0:513:d23:7bf6 with SMTP id
 x13-20020ac259cd000000b005130d237bf6mr1789826lfn.21.1709661691581; Tue, 05
 Mar 2024 10:01:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304104409.2326422-6-ardb+git@google.com> <20240304104409.2326422-8-ardb+git@google.com>
In-Reply-To: <20240304104409.2326422-8-ardb+git@google.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 Mar 2024 20:00:55 +0200
Message-ID: <CAC_iWjKeKBd3O-i8Lodv4m5e8n=0Bss0N_mjc+jCj2QNgmaQzA@mail.gmail.com>
Subject: Re: [PATCH 2/4] efi/libstub: Add Confidential Computing (CC)
 measurement typedefs
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Ard,

On Mon, 4 Mar 2024 at 12:44, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> If the virtual firmware implements TPM support, TCG2 protocol will be
> used for kernel measurements and event logging support. But in CC
> environment, not all platforms support or enable the TPM feature. UEFI
> specification [1] exposes protocol and interfaces used for kernel
> measurements in CC platforms without TPM support.
>
> More details about the EFI CC measurements and logging can be found
> in [1].
>
> Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#efi-cc-measurement-protocol [1]
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> [ardb: Drop code changes, keep typedefs and #define's only]
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/efistub.h | 79 ++++++++++++++++++++
>  include/linux/efi.h                    |  1 +
>  2 files changed, 80 insertions(+)
>

[...]

> +
> +struct efi_cc_event {
> +       u32 event_size;
> +       struct {
> +               u32 header_size;
> +               u16 header_version;
> +               u32 mr_index;
> +               u32 event_type;
> +       } __packed event_header;
> +       u8 event_data[0];

We should define this as a flexible array member instead of a zero-length array?
The spec is funny and defines this as event_data[1]. I think we aren't
using the sizeof(struct efi_cc_event) anywhere, so if this struct is
not used as a member of another struct or an array we can omit it
entirely.

[...]

Cheers
/Ilias

