Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF7145849C
	for <lists+linux-efi@lfdr.de>; Sun, 21 Nov 2021 17:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbhKUQID (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 21 Nov 2021 11:08:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhKUQID (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 21 Nov 2021 11:08:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 458E060E90
        for <linux-efi@vger.kernel.org>; Sun, 21 Nov 2021 16:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637510698;
        bh=lV4xGDYQpIaS1b9nPhQg6ePAEMdyx/EdFIZCvV77VpA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UIF7xNKtsVl/YTH3/XXQds4aQpkXrarS/zrDCjc9WtZV0K7McNRzYKwsi560gvoG9
         4EPcPjCLxhcJ0KmjU8lPdTXF5bQEiORsZEkgVuSQriQ4RpFgi5z9tB6wNjdtMDsh/5
         g38U1bD99LtKcg0DXSpNBZ5RBMQX1SX69PhXIpjjiI4r9t72Xax+9E2A/BUbBIX0aG
         c9cbKhKQrXABmL4iGJSwEtYGIgiOnkNaTMVRnIo4QbVuQ/mMtHFAAZCT08mfuEyDAX
         F9WWvqdaZKG/yWA2g+5hXWL5E1KFmMhAt4JR4vfw1rcwYDwUWX9EyzPMFW6FZALAvS
         +5D7S+ez8z1Fg==
Received: by mail-oi1-f177.google.com with SMTP id t23so32785393oiw.3
        for <linux-efi@vger.kernel.org>; Sun, 21 Nov 2021 08:04:58 -0800 (PST)
X-Gm-Message-State: AOAM531dS+grDxaPSjSrS43gwYXixNrl/mzeZkLpRfXHOmCEijsZ65JE
        NBbC9ddXedCVsnxNHxogHbgqq9l2whCSQWS0sDg=
X-Google-Smtp-Source: ABdhPJzMJnp+1PpTg/3Fsr83RLXnP79tmFJvqq8DP0BWZ/GCuXwh4tS7GR3flr1wizsTAw8jw6CjC+YxSmhMS4fwORw=
X-Received: by 2002:a05:6808:12:: with SMTP id u18mr15214369oic.174.1637510697562;
 Sun, 21 Nov 2021 08:04:57 -0800 (PST)
MIME-Version: 1.0
References: <20211028210517.10881-1-ehaouas@noos.fr>
In-Reply-To: <20211028210517.10881-1-ehaouas@noos.fr>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 21 Nov 2021 17:04:46 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFPVvkhxOiCNTW+tDt2n8=obbeagsunXxw4USW+BpURSw@mail.gmail.com>
Message-ID: <CAMj1kXFPVvkhxOiCNTW+tDt2n8=obbeagsunXxw4USW+BpURSw@mail.gmail.com>
Subject: Re: [PATCH] include/linux/efi.h: Remove unneeded whitespaces before tabs
To:     Elyes HAOUAS <ehaouas@noos.fr>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 28 Oct 2021 at 23:11, Elyes HAOUAS <ehaouas@noos.fr> wrote:
>
> Signed-off-by: Elyes HAOUAS <ehaouas@noos.fr>

Queued, thanks.

> ---
>  include/linux/efi.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 6b5d36babfcc..d009149df23c 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -569,8 +569,8 @@ extern struct efi {
>         unsigned long                   flags;
>  } efi;
>
> -#define EFI_RT_SUPPORTED_GET_TIME                              0x0001
> -#define EFI_RT_SUPPORTED_SET_TIME                              0x0002
> +#define EFI_RT_SUPPORTED_GET_TIME                              0x0001
> +#define EFI_RT_SUPPORTED_SET_TIME                              0x0002
>  #define EFI_RT_SUPPORTED_GET_WAKEUP_TIME                       0x0004
>  #define EFI_RT_SUPPORTED_SET_WAKEUP_TIME                       0x0008
>  #define EFI_RT_SUPPORTED_GET_VARIABLE                          0x0010
> @@ -837,7 +837,7 @@ extern int efi_status_to_err(efi_status_t status);
>  #define EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS 0x0000000000000020
>  #define EFI_VARIABLE_APPEND_WRITE      0x0000000000000040
>
> -#define EFI_VARIABLE_MASK      (EFI_VARIABLE_NON_VOLATILE | \
> +#define EFI_VARIABLE_MASK      (EFI_VARIABLE_NON_VOLATILE | \
>                                 EFI_VARIABLE_BOOTSERVICE_ACCESS | \
>                                 EFI_VARIABLE_RUNTIME_ACCESS | \
>                                 EFI_VARIABLE_HARDWARE_ERROR_RECORD | \
> --
> 2.33.0
>
