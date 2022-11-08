Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC886207BC
	for <lists+linux-efi@lfdr.de>; Tue,  8 Nov 2022 04:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiKHDsX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Nov 2022 22:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiKHDsW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Nov 2022 22:48:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F3327174
        for <linux-efi@vger.kernel.org>; Mon,  7 Nov 2022 19:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667879244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ev+fSyyBqcCfTMaT7CFLA0J4Ic6L9zpUlTq1fwLWoSc=;
        b=JbrPhitX586bkdh1YV5j4fK3lXsCBmz2s279/L5VwrraJg4yZC5aMVpnLz6YuoMQtzNy11
        0rJxiKhUOAD0ABEWinwXl/xEMuanTH+2SQPSZbAqVmV1Ywx81zzc98gDO81buh9RveWyYK
        FRVighHhoVVlo6gzyMOEQc4JPtJpK1c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-386-MSSuqJzrMTKmUtzM-o2tmQ-1; Mon, 07 Nov 2022 22:47:22 -0500
X-MC-Unique: MSSuqJzrMTKmUtzM-o2tmQ-1
Received: by mail-ed1-f69.google.com with SMTP id x18-20020a05640226d200b00461e027f704so9546897edd.7
        for <linux-efi@vger.kernel.org>; Mon, 07 Nov 2022 19:47:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ev+fSyyBqcCfTMaT7CFLA0J4Ic6L9zpUlTq1fwLWoSc=;
        b=CkIqfqhbAINJA/M6s7B4uLEKpekEZEKMxP2UXHNCMoiDePqOZL/lYhXgN99E7DA9U3
         4iuanfNYliV7LfDKLvA+/98hv2WLl268ev6nTML7nkIVZXjsqGLPZd2SnbFqXD+20hq6
         HmmY8OiDKja9ar+Z3J3D3QMN6ERRYxT/6MF+mV5+RNT86E3/ApFyC+2/ZVfRGWq+3F73
         CHuVYPnqwLmx+yPxeaPh/qrdZYh4fTV259DcSzd9QxM4LfDJtH67ndCRWnENbW8qQjKU
         0bNFZN4/BXH8y4UBUlSxFGk+C7bFD3FZ902/6B28vv2RCROMOpRdFTz9jbqZYJDskbvb
         qPOw==
X-Gm-Message-State: ANoB5pmJSXLIJKoMBUe9vS3lOkeLMllzwv3RgrEzDxrCVdUBYriO09hc
        jo8fbjRr3rfqGrhNJ2ZZVc4cVHkTAA/SKlaPt1QqK6NheFur/q+zlSWpKLISd7ZNuqZKpIMfuvm
        ESjOux69ZkdYvNF5UdJ2Bm9LJj7CFonO8MqiF
X-Received: by 2002:aa7:d385:0:b0:461:8cd3:b38b with SMTP id x5-20020aa7d385000000b004618cd3b38bmr15153849edq.172.1667879241503;
        Mon, 07 Nov 2022 19:47:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf77M6/GlYM6rgWK3eXWzziktsUCBEP2LHlgeOQqbUpsLPfvrwYyeo0y7C1w5UmCnjMVkgGH6QSUX6lIZoedWAI=
X-Received: by 2002:aa7:d385:0:b0:461:8cd3:b38b with SMTP id
 x5-20020aa7d385000000b004618cd3b38bmr15153842edq.172.1667879241325; Mon, 07
 Nov 2022 19:47:21 -0800 (PST)
MIME-Version: 1.0
References: <20221107083134.234918-1-ardb@kernel.org>
In-Reply-To: <20221107083134.234918-1-ardb@kernel.org>
From:   Dave Young <dyoung@redhat.com>
Date:   Tue, 8 Nov 2022 11:46:42 +0800
Message-ID: <CALu+AoRXJbvYWoKijLt2vK2G-zsv7ro8d4NEMOsLrowsmrYmKw@mail.gmail.com>
Subject: Re: [PATCH 0/2] efi/x86: Move runtime map sysfs code into arch/x86
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Mon, 7 Nov 2022 at 16:31, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The EFI runtime map code is only used on x86, so let's move it out of
> the generic code and into arch/x86. While at it, clarify the Kconfig
> description so that it gets enabled automatically when required (i.e.,
> when kexec is enabled), and can only be disabled when CONFIG_EXPERT=y
>
> Ard Biesheuvel (2):
>   efi: runtime-maps: Clarify purpose and enable by default for kexec
>   efi: x86: Move EFI runtime map sysfs code to arch/x86

For the series:

Reviewed-by: Dave Young <dyoung@redhat.com>

>
>  arch/x86/Kconfig                                          | 11 ++++++++
>  arch/x86/include/asm/efi.h                                | 22 +++++++++++++++
>  arch/x86/platform/efi/Makefile                            |  1 +
>  {drivers/firmware => arch/x86/platform}/efi/runtime-map.c |  6 ++---
>  drivers/firmware/efi/Kconfig                              | 11 --------
>  drivers/firmware/efi/Makefile                             |  1 -
>  drivers/firmware/efi/efi.c                                |  5 +---
>  include/linux/efi.h                                       | 28 --------------------
>  8 files changed, 38 insertions(+), 47 deletions(-)
>  rename {drivers/firmware => arch/x86/platform}/efi/runtime-map.c (97%)
>
> --
> 2.35.1
>

