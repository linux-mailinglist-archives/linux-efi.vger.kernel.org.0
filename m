Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA825F8273
	for <lists+linux-efi@lfdr.de>; Sat,  8 Oct 2022 04:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJHCg4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Oct 2022 22:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJHCgz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Oct 2022 22:36:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFE0127926
        for <linux-efi@vger.kernel.org>; Fri,  7 Oct 2022 19:36:54 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id i7-20020a17090a65c700b0020ad9666a86so8768882pjs.0
        for <linux-efi@vger.kernel.org>; Fri, 07 Oct 2022 19:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BhwPrOuYUwoWzRSktEsVhVADMKFqjhqc+NN8M06UFVQ=;
        b=X2+wqrrC1epfsfjZd6c945cE5qsFPLh2kXOPBFlPs4d+maA1HHm84N4prBkJ+mRwUQ
         R5U8jBYHa0pzXG3r2xBpIpz8jnWAStmK7d8UAn0nKTje3jtPDAhyBls9fgLb13LQkJtr
         DaJbiIKTYYtQGpmyRed+VjffyPfBecFwXYU5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BhwPrOuYUwoWzRSktEsVhVADMKFqjhqc+NN8M06UFVQ=;
        b=qcc2HqsdZ05hpjfJp+TDRZCiJyx7cp4MPQbPUbTuWCKHr3Y/n2vI+AI3nnhnQrOt7e
         jPpJR9CrvT6spW/fdIOwNmuQoqzZ2SCpBK+V1M6PV5l26MyCeJOi71z7siq9i/sIkbrq
         tcx2iSJgVw9MBybPbYpIX2Ktf7Bu6If9W1FLaixFlxMmENlRREYXfqU4yI4PLjlBlxqa
         W5aFiMaKka4YywWo7u8rVEphWkidM3kiCWPyVnEFrnnHBrQPRBGg6LCXMEsL3PNa749K
         XExcRPp0/8VL21Lo97EC7NiM4ooE72TRWRhVMxh/vhQZZgGkJCXk8Fs87cswFZeXMUtx
         KIWw==
X-Gm-Message-State: ACrzQf0wKg0eKAZD3axmNDbUFAtvBBnMH0eRLyQRHQFNX0t+0uu7qVT4
        X7zj2NNvThhFkuPF+RhABbVpbhgElKKCIw==
X-Google-Smtp-Source: AMsMyM70GenZvtpj/9K5xkd2D0aAutcWDIhWfx1adPycILvsyUBR8+KQtJUnl4JpYz7kYGjr7GL5Ng==
X-Received: by 2002:a17:90b:1e46:b0:20a:c49f:9929 with SMTP id pi6-20020a17090b1e4600b0020ac49f9929mr8303651pjb.221.1665196613803;
        Fri, 07 Oct 2022 19:36:53 -0700 (PDT)
Received: from [127.0.0.1] (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z11-20020a63190b000000b0042aca53b4cesm2365872pgl.70.2022.10.07.19.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 19:36:53 -0700 (PDT)
Date:   Fri, 07 Oct 2022 19:36:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
CC:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, linux-efi@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_8/8=5D_efi=3A_pstore=3A_Add_modul?= =?US-ASCII?Q?e_parameter_for_setting_the_record_size?=
User-Agent: K-9 Mail for Android
In-Reply-To: <cc5945c8-3aa6-980d-902f-ac72f1f3902c@igalia.com>
References: <20221006224212.569555-1-gpiccoli@igalia.com> <20221006224212.569555-9-gpiccoli@igalia.com> <202210061614.8AA746094A@keescook> <CAMj1kXF4UyRMh2Y_KakeNBHvkHhTtavASTAxXinDO1rhPe_wYg@mail.gmail.com> <f857b97c-9fb5-8ef6-d1cb-3b8a02d0e655@igalia.com> <CAMj1kXFy-2KddGu+dgebAdU9v2sindxVoiHLWuVhqYw+R=kqng@mail.gmail.com> <2a341c4d-763e-cfa4-0537-93451d8614fa@igalia.com> <202210071230.63CF832@keescook> <cc5945c8-3aa6-980d-902f-ac72f1f3902c@igalia.com>
Message-ID: <A9E81CC6-089A-42E4-AFD6-588F2E015946@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On October 7, 2022 4:29:55 PM PDT, "Guilherme G=2E Piccoli" <gpiccoli@igal=
ia=2Ecom> wrote:
>On 07/10/2022 16:32, Kees Cook wrote:
>> [=2E=2E=2E]
>> Given OVMF showing this as a max, it doesn't seem right to also make
>> this a minimum? Perhaps choose a different minimum to be enforced=2E
>
>Hi Kees! Through my tests, I've noticed low values tend to cause issues
>(didn't go further in the investigation), IIRC even 512 caused problems
>on "deflate" (worked in the others)=2E
>
>I'll try again 512 to see how it goes, but I'm not so sure what would be
>the use of such low values, it does truncate a lot and "pollute" the
>pstore fs with many small files=2E But I can go with any value you/Ard
>think is appropriate (given it works with all compression algorithms
>heh) - currently the minimum of 1024 is enforced in the patch=2E

Right, but not everyone uses compression=2E On the other hand, this was ne=
ver configurable before, so, sure, let's do 1k as a minimum=2E (And a comme=
nt in the source=2E)


--=20
Kees Cook
