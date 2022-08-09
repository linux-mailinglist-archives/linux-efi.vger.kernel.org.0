Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D8858DA31
	for <lists+linux-efi@lfdr.de>; Tue,  9 Aug 2022 16:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiHIOTY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Aug 2022 10:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237529AbiHIOTW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 Aug 2022 10:19:22 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DDB11C2F
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 07:19:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x21so15320631edd.3
        for <linux-efi@vger.kernel.org>; Tue, 09 Aug 2022 07:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y9uYdy3bduQCBpWjUDHu3oclImwIBNlrcqMqxoKLwew=;
        b=NIQVm14K8whJvA2TZC7Oygw+v/YO50x8920N2kKVCHE2spSwO18eC/lpvyrHP8ullh
         74bnUoUjsZl9mlGhGqy6afN8Hyh2FSX7oiOrDlfKPvNMDpDTtJtzMLovTqkmqch5DjHa
         Sz6hhLj0HadTYWT1TQrRy1sZJGWEBZUSbKQ8h2kznczZAH1ypjhXXq26fve0cdLnq9J5
         T+sQNo5Wxu2kR+pscG4UL87s7ZQaZA9iSzELAXfysiZruTQT/QVW7xuwlVpd+90lLKEs
         kSz/N3dhvmmJBrnYBMxuSWuQyKM2zyKEQOLPHekP5lGT/APVt3T2gV0jN9t5qj9XqR/p
         FfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y9uYdy3bduQCBpWjUDHu3oclImwIBNlrcqMqxoKLwew=;
        b=fQcC8F0mAprTMImtZ79ZCZF1wIKsJScoy8Hh0tRRn+p8n76FdfVAq0GoRKVPuWCjbK
         1TLhuQcEqhUh182r0zDZiURsFbr99wPo+wQo2K1YCiVy+IVPDUvubW6lHkALRo+pGXnl
         Ko0yy61qaAF3UPM5KO9W+XQraJNYD1Xhoy9Oq7aO+tYbOctrvioWlbjwKltMr1mRhTrR
         DCkhjaI0M+mls13CUn8xFQYAfUr0OQ2Fe+olkf570UgfPpKBQ88SLmCRS6Be98FrqrZ0
         Acd6PZofa/9M4h/+0mg/k6GDOamgzLQc5VKPkdlEMhjucFrSPCCEWLlA0axxssN8trWO
         lnMA==
X-Gm-Message-State: ACgBeo3RR7XHvth5GqXLFIZjQV/oNvFu96fFagSaey1Vq49e5K8K5ANz
        74+Rj6q3hnr8ohuQ6mvqMPG6JQ/Xpz1N9A==
X-Google-Smtp-Source: AA6agR78WAg3Kv3B4gkjY86IkmeGenrNftIHZx2lR0ACTrQ15Ln1bUoz1BEB1tXOyqqqUb2H7XGKtA==
X-Received: by 2002:a05:6402:369a:b0:43d:75c5:f16c with SMTP id ej26-20020a056402369a00b0043d75c5f16cmr21792123edb.57.1660054759945;
        Tue, 09 Aug 2022 07:19:19 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id p8-20020a17090653c800b007305b8aa36bsm1174995ejo.157.2022.08.09.07.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 07:19:19 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <50215d9d-0a72-dea1-30dd-6abec36b0c14@redhat.com>
Date:   Tue, 9 Aug 2022 16:19:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3] hw/i386: place setup_data at fixed place in memory
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, qemu-devel@nongnu.org,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Laszlo Ersek <lersek@redhat.com>, linux-efi@vger.kernel.org
References: <YuxOgtykRQb1HU3e@zx2c4.com>
 <20220804230411.17720-1-Jason@zx2c4.com>
 <40fdfb11-1e40-a36a-d3a4-fcbef546a78a@redhat.com>
 <CAMj1kXFDs8HCCCcVAVwjLcATh6MYcUSAha5yvi0ftMw+Ddy_Xg@mail.gmail.com>
 <0bd57fab-836b-9898-9e3f-84dc66eca175@redhat.com>
 <20220809051644-mutt-send-email-mst@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220809051644-mutt-send-email-mst@kernel.org>
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

On 8/9/22 11:17, Michael S. Tsirkin wrote:
>> 1) if we believe "build setup_data in QEMU" is a feasible design that only
>> needs more yak shaving, we can keep the code in, but disabled by default,
>> and sort it out in 7.2.
>>
>> 2) if we go for an alternative design, it needs to be reverted.  For example
>> the randomness could be in _another_ fw_cfg file, and the linuxboot DMA can
>> patch it in the setup_data.
>>
>> With (2) the OVMF breakage would be limited to -dtb, which more or less
>> nobody cares about, and we can just look the other way.
> 
> So IIUC you retract your pc: add property for Linux setup_data random
> number seed then? It's neither of the two options above.

That one would be a base for (1).

Another choice (3) is to put a pointer to the first setup_data in a new 
fw_cfg entry, and let the option ROMs place it in the header.

In any case, as Laszlo said this [PATCH v3] does not work because 
0xf0000 is mapped as ROM (and if it worked, it would have the same 
problem as the first 640K).

Paolo
