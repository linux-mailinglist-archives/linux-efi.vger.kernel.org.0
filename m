Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D5E5A4D13
	for <lists+linux-efi@lfdr.de>; Mon, 29 Aug 2022 15:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiH2NJW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Aug 2022 09:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiH2NIl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Aug 2022 09:08:41 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53854252AA;
        Mon, 29 Aug 2022 06:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pdDi8Hto3QQlhAqHUYRAutf609+jWwmbLMpT1YKx2Y0=; b=rDaq7KdM9lfijXKqTBmGn/7Cp7
        waRr4eq4L8rXMT54TdUUOtJpceLfJHWCSs9IMroDw1SejU1RVAsbT+OjSwP2D3UZYUpjJ5GLw7Wuo
        daPXDOFr4IckygiD3NLf//RoVCw6SiYnfiMRSoioJpIqH/g2ctJ3rQtlYe7QJHOWNbZcwiYYnJw3H
        afpj4yedD40VTS7smYdwOzUCBjLtS/Wge1FbiZ9gaPHu+W4Np2xqqhHBeMenVGc/tSk+g5vBjlr4D
        qFVhIbj0S1SEx83YnBM+2eYy1qC2x01nOAfIzSLq+pqZRFgSoRtS2MgvVMVFxIvmmGt9k0xEhTKpM
        hU51sohA==;
Received: from 189-69-202-182.dial-up.telesp.net.br ([189.69.202.182] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oSeRJ-0046Jh-By; Mon, 29 Aug 2022 15:04:29 +0200
Message-ID: <468b8369-84c2-da12-1eb0-6ec16d160b34@igalia.com>
Date:   Mon, 29 Aug 2022 10:04:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 0/3] The UEFI panic notification mechanism, 2nd round
Content-Language: en-US
To:     ardb@kernel.org, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, anton@enomsg.org, ccross@android.com,
        keescook@chromium.org, matt@codeblueprint.co.uk,
        mjg59@srcf.ucam.org, tony.luck@intel.com
References: <20220729194532.228403-1-gpiccoli@igalia.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220729194532.228403-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 29/07/2022 16:45, Guilherme G. Piccoli wrote:
> Hey folks, this is the 2nd iteration of the patchset adding a simple
> mechanism to notify the UEFI firmware about a panic event in the kernel.
> V1 here:
> https://lore.kernel.org/lkml/20220520195028.1347426-1-gpiccoli@igalia.com/
> 
> 
> First thing, the differences in this V2:
> 
> - Ardb response in V1 mentioned a refactor aimed for v5.20 that removes an
> obsolete/confusing way of setting EFI variables - this led to a weird
> condition, deleted variables stayed in sysfs after deletion. Well, I've
> refactored the code based on efi/next, so I'm using the recommended API
> now - thanks a bunch for the advice Ardb!
> 
> - I've changed NULL-terminating char in patch 1 to the format I've seen
> in Ardb's code, L'\0'.
> 
> - Patch 2 is new, it's somewhat a fix for a patch only in efi/next, part
> of the efivar refactor.
> 
> 
> In the V1 review, it was mentioned we could maybe use efi-pstore as a way
> to signal the firmware about a panic event - in the end, the efi-pstore
> mechanism can collect a dmesg, so it's even richer in the information level.
> But I disagree that it is the way to go, for 3 main reasons:
> 
> a) efi-pstore could be impossible to use, if the users are already using
> another pstore backend (like ramoops), which is _exactly_ our case!
> Of course, we could rework pstore and allow 2 backends, quite a bit of work,
> but...see next points!
> 
> b) Even if (a) is a not an issue, we have another one, even more important:
> signaling the firmware about a panic is *different* than collecting a bunch
> of data, a full dmesg even. This could be considered a security issue for
> some users; also, the dmesg collected consumes a bunch more memory in the
> (potentially scarce) UEFI available memory.
> Although related, the goal of pstore is orthogonal to our mechanism here:
> users rely on pstore to collect data, our proposal is a simple infrastructure
> to just let the firmware know about a panic. Our kernel module also shows a
> message and automatically clears the UEFI variable, so it tracks a single
> panic, whereas efi-pstore logs are kept by default, in order to provide
> data to users.
> 
> c) Finally, it's faster and less "invasive"/risky to just write a byte in a
> variable on a panic event than having a ksmg dumper collecting the full dmesg
> and writing it to the UEFI memory; again, some users wish to have the logs,
> but not all of them.
> 
> 
> With all of that said, I think this module makes sense, it's a very simple
> solution that opens doors to firmware panic handling approaches, like in our
> proposed case (a different splash screen on panic).
> 
> Finally, the variable name (PanicWarn) and value (0xFF by default, can be
> changed by a module parameter) are just my personal choices but I'm open to
> suggestions, not strongly attached to them heh
> 
> Thanks again for the reviews/suggestions!
> Cheers,
> 
> 
> Guilherme
> 
> 

Hi Ard, sorry for the ping =]

Any opinions in this one? Patch 2 is a simple fix, BTW.
Cheers,


Guilherme
