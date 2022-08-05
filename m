Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883D158AEDD
	for <lists+linux-efi@lfdr.de>; Fri,  5 Aug 2022 19:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiHER3e (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Aug 2022 13:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiHER3d (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Aug 2022 13:29:33 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AA9183BE
        for <linux-efi@vger.kernel.org>; Fri,  5 Aug 2022 10:29:32 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id w19so6170871ejc.7
        for <linux-efi@vger.kernel.org>; Fri, 05 Aug 2022 10:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UNS86hfrKr5PjDXv5fVr7SKBuuY/cCQChY55vbePDlw=;
        b=LlRkQfojbDHMer07Mi7PSDRP6J7y5x4g8Z2hvK6+XwxUgILIDjjGg5HsQxfIQBaRQC
         hokrGVF7O5r9WJbP/yFQhZG5AIIDCZIH4T0lRtYM2vQ1Cw2TL2W72pbANRt2+28d6vAs
         lVQoLqce/Su4MxPWI5flpM8rUItn/mOBhNArYvPc4CW3Lb/FQRHw9ZmPcwuFvDF06UTQ
         c4I93n5tvcJCbbjH7o9s9TnED+gaP9pEAQQ2QT8TdPOM6cETQSiZCfTxq4ReIsj5Eero
         xFVtz9S2M/O9M/NbQh91Jf9/mytnNhJK6YgSI1SEh/GltDC9Hvfho1o9Y2r6o1KWEBIj
         ZvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UNS86hfrKr5PjDXv5fVr7SKBuuY/cCQChY55vbePDlw=;
        b=dej7K7RfzHPX+bVYLLdWrXS3q0XlJiBXrG9o4emy6z2Vwwz2fgTfDHqXO11TYlcwiC
         CcahzWKFSm9zd+1Q7FG/ijm48vqNtq4rMTKIKUJDMSSw4ssJGIMHoMkKFbQVQE9mclWZ
         FmDzHl7hjASOrIPp7GsE+XDT7Fz/n/g8BcyiXTjqQ6Qd3DTE0YPlxi6OG7v+0ENfb9Pc
         MSiGEZ+BZyzvH1EFwItg2sBctmf+7/r5ElAgZeImgJZ5j502wW/hV97TwSX4o0Ro3TuH
         E+JONP6D/IQmnj0fvh/AFCuRqFGsm4psc9lTJpbFUY56YBVnTvCsWL22QbGNFPvo0eDy
         bzTg==
X-Gm-Message-State: ACgBeo3VG3/jB/zS72kJcrC2NfKbYo+aHJGsQySxFcOj79RGPKuwvfIb
        lqrZfqXoufE7ckxu1X6XEiw=
X-Google-Smtp-Source: AA6agR4JpoSoFCvOy4jpeEJWseIzUrYJ0H1qm4Zu3ZHXaXFCOpLpqXK2dd9ON3YfE3OSw7NBoQTKwQ==
X-Received: by 2002:a17:906:974c:b0:731:14e2:af11 with SMTP id o12-20020a170906974c00b0073114e2af11mr787658ejy.220.1659720571348;
        Fri, 05 Aug 2022 10:29:31 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id b18-20020a170906d11200b00730a18a8b68sm1794108ejz.130.2022.08.05.10.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 10:29:30 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <0bd57fab-836b-9898-9e3f-84dc66eca175@redhat.com>
Date:   Fri, 5 Aug 2022 19:29:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] hw/i386: place setup_data at fixed place in memory
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, qemu-devel@nongnu.org,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Laszlo Ersek <lersek@redhat.com>, linux-efi@vger.kernel.org
References: <YuxOgtykRQb1HU3e@zx2c4.com>
 <20220804230411.17720-1-Jason@zx2c4.com>
 <40fdfb11-1e40-a36a-d3a4-fcbef546a78a@redhat.com>
 <CAMj1kXFDs8HCCCcVAVwjLcATh6MYcUSAha5yvi0ftMw+Ddy_Xg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAMj1kXFDs8HCCCcVAVwjLcATh6MYcUSAha5yvi0ftMw+Ddy_Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/5/22 13:08, Ard Biesheuvel wrote:
>>
>> Does it work to place setup_data at the end of the cmdline file instead
>> of having it at the end of the kernel file?  This way the first item
>> will be at 0x20000 + cmdline_size.
>>
> Does QEMU always allocate the command line statically like that?
> AFAIK, OVMF never accesses that memory to read the command line, it
> uses fw_cfg to copy it into a buffer it allocates itself. And I guess
> that implies that this region could be clobbered by OVMF unless it is
> told to preserve it.

No it's not. :(  It also goes to gBS->AllocatePages in the end.

At this point it seems to me that without extra changes the whole 
setup_data concept is dead on arrival for OVMF.  In principle there's no 
reason why the individual setup_data items couldn't include interior 
pointers, meaning that the setup_data _has_ to be at the address 
provided in fw_cfg by QEMU.

One way to "fix" it would be for OVMF to overwrite the pointer to the 
head of the list, so that the kernel ignores the setup data provided by 
QEMU. Another way would be to put it in the command line fw_cfg blob and 
teach OVMF to use a fixed address for the command line.  Both are ugly, 
and both are also broken for new QEMU / old OVMF.

In any case, I don't think this should be fixed so close to the release. 
  We have two possibilities:

1) if we believe "build setup_data in QEMU" is a feasible design that 
only needs more yak shaving, we can keep the code in, but disabled by 
default, and sort it out in 7.2.

2) if we go for an alternative design, it needs to be reverted.  For 
example the randomness could be in _another_ fw_cfg file, and the 
linuxboot DMA can patch it in the setup_data.


With (2) the OVMF breakage would be limited to -dtb, which more or less 
nobody cares about, and we can just look the other way.

Paolo
