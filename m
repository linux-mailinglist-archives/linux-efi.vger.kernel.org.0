Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AB1622644
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 10:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiKIJHt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 04:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiKIJHR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 04:07:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4801FFA4;
        Wed,  9 Nov 2022 01:07:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 705CDB81D49;
        Wed,  9 Nov 2022 09:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E286C433D6;
        Wed,  9 Nov 2022 09:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667984834;
        bh=W/88hguvkeMribQ0McBdIZSxuj8hILVwciXjXqgqxSU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oF1BM9jDa8AyCSsyrpqHeaAobhAnpEv6ZeE1OH28jZkHN2TQ2x0Um+XL0xPYp1fyH
         XALmcuyIb+i74uoQnpBOVKKm4BeOJWJCcFhd//fCe5m8HHtm3IK/Hwp0mfnKggarJu
         UWfXtSOYQDnh3kVktwcN6xA2/aUy/10Wtc6yBvc0joOVPs3tJRqFdV/g7w1ZTg/88W
         ebLhR+y6n/mkPY5BnOLMCXQudrlUzt0mUUNn7fHj2ANJRXpmsNVnFx7eMoL38EVlsJ
         oyvLtbsVR2hjMNzsW0JChA9F3pFn7UayF24WufgKyZMfU5EhrnfZKU1wVyEeGkXNUz
         p/2aNt+LNhhBg==
Received: by mail-lf1-f51.google.com with SMTP id g7so24737451lfv.5;
        Wed, 09 Nov 2022 01:07:13 -0800 (PST)
X-Gm-Message-State: ACrzQf39+0PXrWgjFq76r3h317oonhxD+XmGGq2C1VLBmVClQPr4Yf7l
        oRrw/2qK5TN598HMX22J7yW4MrxRAHYIuHZNVUo=
X-Google-Smtp-Source: AMsMyM7v8NI3X/GOHTJ/Q59gWtqQ91LAgvbTV+TwbRoRS/dYsGM/c5JngOfg0qCI5boQrCxaKlkKiy7RGw9j3XABs84=
X-Received: by 2002:a05:6512:151b:b0:4af:e7d3:4a46 with SMTP id
 bq27-20020a056512151b00b004afe7d34a46mr19960192lfb.583.1667984832050; Wed, 09
 Nov 2022 01:07:12 -0800 (PST)
MIME-Version: 1.0
References: <Y2lAB508TrrjpDPi@monolith.localdoman> <CAMj1kXE1jXd_+UAgBvi2kKMMxQErH8EDAHU06mD85Es0OfsYsQ@mail.gmail.com>
 <Y2oq79NaCn6UKkLw@monolith.localdoman>
In-Reply-To: <Y2oq79NaCn6UKkLw@monolith.localdoman>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 9 Nov 2022 10:07:00 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGswMfSXYmr=LyAOusYjq6eLqC9oPRRCEaR-1u-kFu4Hw@mail.gmail.com>
Message-ID: <CAMj1kXGswMfSXYmr=LyAOusYjq6eLqC9oPRRCEaR-1u-kFu4Hw@mail.gmail.com>
Subject: Re: [Possible BUG] arm64: efi: efi_runtime_fixup_exception() and
 efi_call_virt_check_flags() both taint the kernel
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 8 Nov 2022 at 11:10, Alexandru Elisei <alexandru.elisei@arm.com> wrote:
>
...
>
> Speaking as an user, I think it would be nice to revert the commit, that's
> how I am running v6.1-rcX kernels on the machine, as updating the firmware
> is not feasible right now. But I realize that I'm not the one maintaining
> the code, so I don't have a strong opinion about it :) And it's better now
> than it was at rc3, when the kernel was panicing.
>

I sent out a patch yesterday that tweaks the sync exception fixup
handler to only disable the runtime service that triggered the
exception. This means, of course, that you might hit it multiple times
if several runtime service implementations are buggy, but there are
only five or so that we actually use, so that shouldn't make a huge
difference. But it also means a) we don't trigger other code paths
that freak out when a runtime service that was available suddenly goes
away and b) the diagnostics are more useful because we will find out
which other runtime services are broken.

Could you please test that patch? And for good measure, could you try
something like

efibootmgr -t 3

(as root) to exercise the SetVariable() path as well?
