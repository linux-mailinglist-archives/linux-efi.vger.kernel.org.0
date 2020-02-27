Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3EE51714C9
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 11:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgB0KMF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Feb 2020 05:12:05 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36366 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbgB0KMF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 27 Feb 2020 05:12:05 -0500
Received: by mail-lf1-f68.google.com with SMTP id f24so1651427lfh.3
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2020 02:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=23xg3xXgAfGKhWk8U0pLr4SmL7oKXrfhT/YKVSMTCAs=;
        b=cNwEapeFUzaWpVHyTde34ajOhYtNgyscBOY0MMR7uoUnIttkKKjV8jTh8GqQdMDbgO
         nZKn2PP4N8AC3WjQfvbK1KY9vCpIMf5CZUleHiQlmNd8Ct4X8IG7jWgIgEHNOOYvGuYW
         0GZKZC4qtpFuySBKmVhGJaG9721lK1J703CXFcNYEZ2yzoHjtGcElxDmb2sC6L0Qf9DA
         rECkOSktr43ZGYKuTdzUu1USz98cH/EKBlMSak66p6bfjiQR14QFpSkFYb6fRBOsHhkS
         wzXA4o0ZGYyDT6Hb6ntwd5dFnLC661+BoV9e4xEPUCsWj9TYeP2G2ie/OQsLcSa8rU0Q
         1bIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=23xg3xXgAfGKhWk8U0pLr4SmL7oKXrfhT/YKVSMTCAs=;
        b=R35xZd+JloE6deqM3VRs+GrvRL0qvSH5HghL435tnue04jmipPAo+5fKwbsVB21eii
         QazhxgZvZfblvBuyjseXUA0kvU976IulJGhqhR+MoP0cxmpE+Tb30KPTNT3DceWyE0tX
         dmFABHEkD62CgW67TLGvRghmm3HUr1xHlwof0XeLRzcHtWhXG/AW7urwzAVZ51rtqHep
         /yEd+zvQTgchBRUzcIV6cGz6bJsCvb37zPsdJZl2fTltl5rfITeAxUItDp2vWUXR5U0E
         EslG0c5+RQtFXux5iQLSf1PvMd4r8n/1NvJPnBKNoOZ9w3+Qal6NRS8EX/YpEsq8qNuu
         qv5w==
X-Gm-Message-State: ANhLgQ0TrCH07MBFRLEBfz5sYLyK8XDfg8eyPekJQrYdD1apghr1te59
        0LG1F9ZEcGugMWb0Xv1cKvlfMiTDxKJliAnt0a5o/w==
X-Google-Smtp-Source: ADFU+vsc2T2jZf70kpZMvYMwpfS+uLg4OObFA/cnTervsw+SJLOvoZvVNj5I9uhJjuGVX8IdlnaMjTx8rjO5JeJrKis=
X-Received: by 2002:a19:ed0b:: with SMTP id y11mr1776494lfy.77.1582798323589;
 Thu, 27 Feb 2020 02:12:03 -0800 (PST)
MIME-Version: 1.0
References: <20200226165738.11201-1-ardb@kernel.org>
In-Reply-To: <20200226165738.11201-1-ardb@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Feb 2020 11:11:52 +0100
Message-ID: <CACRpkdZ9WR7wEjgscAF=Pwy0=YwbNPjtH6BQWa5wfXW74Md4xQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] ARM: decompressor: use by-VA cache maintenance for
 v7 cores
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 26, 2020 at 5:57 PM Ard Biesheuvel <ardb@kernel.org> wrote:

> So instead, switch to the by-VA cache maintenance that the architecture
> requires for v7 and later (and ARM1176, as a side effect).
>
> Changes since v3:
> - ensure that the region that is cleaned after self-relocation of the zImage
>   covers the appended DTB, if present
>
> Apologies to Linus, but due to this change, I decided not to take your
> Tested-by into account, and I would appreciate it if you could retest
> this version of the series? Thanks.

No problem, I have tested it on the following:

- ARMv7 Cortex A9 x 2 Qualcomm APQ8060 DragonBoard
- ARM PB11MPCore (4 x 1176)
- ARMv7 Ux500 Cortex A9 x 2

The PB11MPCore is again the crucial board, if it work on that
board it works on anything, most of the time :D

Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
