Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC2E6B6CD6
	for <lists+linux-efi@lfdr.de>; Mon, 13 Mar 2023 01:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCMAcx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 12 Mar 2023 20:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCMAcw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 12 Mar 2023 20:32:52 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A899339BAC
        for <linux-efi@vger.kernel.org>; Sun, 12 Mar 2023 17:32:51 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c10so6621258pfv.13
        for <linux-efi@vger.kernel.org>; Sun, 12 Mar 2023 17:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678667571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTlpK+NV9bMMlZUpC5CF6V9JYBQl15QaQ5TbxDEGGek=;
        b=ZDHJOH0lqHlyauHhSC22PFQSF2DprDBAw0qun9ZLiYoXVLP7lT+p0u3sZ7M4xNTdZT
         qow078ZrAABLT4LuCpVOC+VuqIMQPQ2atpoIog9ogq6VSXZIBFwYlfcMxB51zPgZjpva
         8QtjjLrZBoSMfV2rpnfAXytQRswZnatCW2eg/INzzDDs+dWnc7kOglqLR4/koviDNr4+
         oHYKN9Da99cTRe7rWGOO2vPCWskyyPXzIdgQMmPhUjk/vHB7NOafu9Oj/mnHyQFeUXc7
         FOdysIC7aY6mnyLky9KcIcVs7JtY8NACufaIQEEBOLq3DR+sJlPpFv0nkcYXLOpInd4N
         7neQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678667571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTlpK+NV9bMMlZUpC5CF6V9JYBQl15QaQ5TbxDEGGek=;
        b=No+gCg8lPUNyHnKlxz71bY8s8a4lvMcfwglHxXR7knsbVEyqTvi0LEDn5YvUycg+i0
         xg8OrNzTOsE6H/au62efXAXhGUT9T2hC/zXfeMu+RWzhw7i7Wbit4uKeOdBYMwODbyGg
         OP8YlCpcsKUXdygJMVO+eIADuVJDF7s0q2pKknxf/aljrDuhPOj1WAY54cQGrq5xqsNq
         Dw/MH97PlfdHUKdQ4k11i1R2ZTapLIJZZASqmTpR9cxAIn4qF9CUEIa/puwcT1ZXPSGX
         xSJa4+XfVG0PFKUpIr26kIpb1z5CsI03eNGBgj/QSxuoXyaN9hHn9CAu7bRroJOUOXt4
         1UNw==
X-Gm-Message-State: AO0yUKWkoH1eU3M3sE8kiskh3+g+cOoKRqFDUfREIL7rytJqotdTmdeW
        YcQ7PV7UChicWMb4KunLsjC6M6RcED47DxU2Fg18Ywp4WITRm6YktFg=
X-Google-Smtp-Source: AK7set/Lcni1U/JPHIlvf+MVYJtsOOkUdjjumRX8FaHkNsiNzIH/dxZON7gWqKVX481Y8Lz7Ajhbm2j47NOUJdXwO/A=
X-Received: by 2002:a05:6a00:2136:b0:590:3182:7ac3 with SMTP id
 n22-20020a056a00213600b0059031827ac3mr12524369pfj.0.1678667571099; Sun, 12
 Mar 2023 17:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230312221221.3653857-1-ardb@kernel.org>
In-Reply-To: <20230312221221.3653857-1-ardb@kernel.org>
From:   Shawn Guo <shawn.guo@linaro.org>
Date:   Mon, 13 Mar 2023 08:32:38 +0800
Message-ID: <CAAQ0ZWTvMzYO+jppqQ=YXnzhmCzR1_cVk1-U6vtMMun+2KwZTQ@mail.gmail.com>
Subject: Re: [PATCH] efi: earlycon: Reprobe after parsing config tables
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Mar 13, 2023 at 6:12=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> Commit 732ea9db9d8a ("efi: libstub: Move screen_info handling to common
> code") reorganized the earlycon handling so that all architectures pass
> the screen_info data via a EFI config table instead of populating struct
> screen_info directly, as the latter is only possible when the EFI stub
> is baked into the kernel (and not into the decompressor).
>
> However, this means that struct screen_info may not have been populated
> yet by the time the earlycon probe takes place, and this results in a
> non-functional early console.
>
> So let's probe again right after parsing the config tables and
> populating struct screen_info. Note that this means that earlycon output
> starts a bit later than before, and so it may fail to capture issues
> that occur while doing the early EFI initialization.
>
> Cc: Xuefeng Li <lixuefeng@loongson.cn>
> Cc: Xuerui Wang <kernel@xen0n.name>
> Cc: Huacai Chen <chenhuacai@loongson.cn>
> Reported-by: Shawn Guo <shawn.guo@linaro.org>
> Fixes: 732ea9db9d8a ("efi: libstub: Move screen_info handling to common c=
ode")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Thanks for the fix!  On Snapdragon laptops:

Tested-by: Shawn Guo <shawn.guo@linaro.org>
