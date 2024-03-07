Return-Path: <linux-efi+bounces-759-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CF3874D06
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 12:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579721C20D22
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 11:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61341126F39;
	Thu,  7 Mar 2024 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rX7AVVUu"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCB485641
	for <linux-efi@vger.kernel.org>; Thu,  7 Mar 2024 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809733; cv=none; b=aNgkpnfWhFDPSvnn2r6VTtkX7JPmDx/ggncmMeQX1Cion7yRu30UiMcQyZzlHrWWXAOt9fD55kKwCVnEPWcw/tJi8NIwqpDboyQz7k8Z+5xBfvGwJbPepII5Jbuej4aa0RTZTlcuHwgjXUXk3O8MoF2P7Nljge0/5ZE6qkVIwlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809733; c=relaxed/simple;
	bh=X/wQkbD7C2kGtQ5uKVwm9FhSK7sRbDoD/67Van1Yv34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFNJ0xbUq54SF+XlDlR5bCUWRfVIxdpdMaAgOaR9pmM/gPUvmpct9KBQnLgE4VJKduEqNNavbedDOt0VsU5eDmUCZl+mrg40c4xMeUajkNYhFCDKIIYr39bcdhRIvCUwKgmsCblhDowXdCup1sWRE4W+zK1evVEwtpSx7ilOksg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rX7AVVUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5479C433C7
	for <linux-efi@vger.kernel.org>; Thu,  7 Mar 2024 11:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709809732;
	bh=X/wQkbD7C2kGtQ5uKVwm9FhSK7sRbDoD/67Van1Yv34=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rX7AVVUuM0Jr/pKO/9MY1GPnvUKWP5DRHdd7O4c21Q9s1uw8qqBatWXmndmjeZIpW
	 2OQZb5C0IajKNVit/TMr06/Q9xJNHjkwfQA1K3Bi6dGGZzAEuTR5ihAB8ZHINSjWb8
	 C6BMG38KAWoD5rYwjw61+gKxeHRtStWsuHwjwaW+zrfT7B1aKko2ZcMnqREXoQEj02
	 65dTf3Moi4tJFuo28HL84BuGDULVt+o2f0wLMhYrdfqXBGDkC8A1Vef98kaERxLk8V
	 PdlLL+ApzwDBPGA04WdXvkAUUnd6AkdaoGB4EiD4TL8LOpB5jsdSWAGGL48/FmyWMs
	 i3iWpj3TViFJg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5134d7e16a8so603284e87.3
        for <linux-efi@vger.kernel.org>; Thu, 07 Mar 2024 03:08:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWcNnjApPL/Cuf7Lw06AXt13DkQC9sgTKUGrejnd5MDb3WPnCCp+6WWZOouByBUkLEU2OsWqn/Vy2rmbMFfL5OWbcyw8XLdBRSA
X-Gm-Message-State: AOJu0Yzw4l208VA9Yu02LORbzwT4yByRdAO3vRrUGV1+9/TM/qfaKoac
	7Ki1mdW1qbX4czYKuma75PtEcBnJxp31LfdZTZ3LrvwYJN8APvXnkq9LW21xlORXe45PL5zpEQP
	/+7QO6Ek83qWRFFMXmGoCuOCfzh0=
X-Google-Smtp-Source: AGHT+IF+pcZvsYXJ0oQSLtB9dW7nEENpWbtvlXLpK37Jey+sFU0Nqcy8xPHJEkGTjijfE7BOiiGBdZ1jGpnLFAEjqwc=
X-Received: by 2002:ac2:4910:0:b0:513:5b16:b469 with SMTP id
 n16-20020ac24910000000b005135b16b469mr1136671lfi.23.1709809730919; Thu, 07
 Mar 2024 03:08:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0229a87e-fb19-4dad-99fc-4afd7ed4099a@collabora.com>
In-Reply-To: <0229a87e-fb19-4dad-99fc-4afd7ed4099a@collabora.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 7 Mar 2024 12:08:39 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE166VdJLWSWo7_3MDw4V3zSuYRx44Z7yqyj5mQVOdDCA@mail.gmail.com>
Message-ID: <CAMj1kXE166VdJLWSWo7_3MDw4V3zSuYRx44Z7yqyj5mQVOdDCA@mail.gmail.com>
Subject: Re: [Bug Report] Bug in "efi/libstub: Add get_event_log() support for
 CC platforms"
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, 
	"Kuppuswamy Sathyanarayanan," <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Muhammad,

Thanks for the report.

On Thu, 7 Mar 2024 at 12:02, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Hi,
>
> The recent patch:
> 276805fb9c305: efi/libstub: Add get_event_log() support for CC platforms
> has introduced
> #define EFI_CC_EVENT_LOG_FORMAT_TCG_2   0x00000002
>
> But EFI_TCG2_EVENT_LOG_FORMAT_TCG_2 has the same numerical value:
> #define EFI_TCG2_EVENT_LOG_FORMAT_TCG_2   0x2
>
> Thus there is dead code in efi_retrieve_tcg2_eventlog() i.e, multiple if
> conditions with (version == 2) I'm unable to decide on what is wrong and
> what is right here. Please have a look.
>

Why is this a problem? The compiler will recognize this and simplify
the conditional. The code as written is semantically correct, the fact
that the symbolic constants resolve to the same numerical value is
just an implementation detail.

