Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD4758A7CB
	for <lists+linux-efi@lfdr.de>; Fri,  5 Aug 2022 10:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbiHEIKJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Aug 2022 04:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240423AbiHEIKH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Aug 2022 04:10:07 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3773076452
        for <linux-efi@vger.kernel.org>; Fri,  5 Aug 2022 01:10:06 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id tl27so3724515ejc.1
        for <linux-efi@vger.kernel.org>; Fri, 05 Aug 2022 01:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LWJToMjFmw81IbzVmJKhwsxxb0xLJlyCLYVHMyjJqJQ=;
        b=FlR4Wbmjl/ogXp05/6PEnr0lprKVkw93+QTxFlVaWPjWD6T/o3CZ4VZEIumNSJCQIY
         5pSh1g2AHpMrBe08O4qMAO4G+VPPR+4ixSi6HgHJvau/hNzVq0Mn01JaDaNPylj4Tecg
         FEqgjm6OCiCTo9oS3UvPlatr1DNBqOnmuvrMOmmyxlrMEiG+T+KnwRl6sJZpkDQe2KXj
         Pp73na2T2w3vHLK+1MXQ0zrxtB7RsVKWllkPoJTbpTygYwzjrB2Psk1hN24Ren83A/8E
         I0r5lo64hrtTGBGARBG/UTApjRyPWk+ugrXeBQ7BZsKBMJeLfRx0BLzBY4EYV1iQvJnI
         1voA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LWJToMjFmw81IbzVmJKhwsxxb0xLJlyCLYVHMyjJqJQ=;
        b=IRwynvH0w/nDFrdfnJr6ED0Ksh4ZppG58OJyddrSMeC73BlhTy8U7lZUChRSqFNNpj
         PxKs3oFkJ4Pgl6xutT8zvb12pIMkIeUexGa1aFxcBXG36IcTaXzJZNsoaNzAkPUklTcC
         +tUioTt3lq0DJKW7Run2zaqKKdC3+64iA0lqMGyXMbupAKNtVg0nymgIcBw2s/gBizVM
         2jS23gcbfHRdVk4/KfR9Rm0aEOi8kL0oXwnOSpli13LNj95vWMC1O0CW6s4coQgyuhE6
         DXci0lL+F4yJgh9L+CGtQbDHXbPVOekaF+716x/iQRGMQQYjJVYIz4cgQmQcOiZxnGO/
         IGBA==
X-Gm-Message-State: ACgBeo0k/elpVQW/ODHkGJpsKDCOklEXgiz5heu4k5DEEbEM17L8pwPB
        ILTZsuUKETro4GLYA7MZG+I=
X-Google-Smtp-Source: AA6agR7oz5nrSgJXAX/jFXXH6x2D7nwmO0ZLbZWfsV/OXUtZlIAq8CjgEGd9f0SJnN/EgLQwOHT5yQ==
X-Received: by 2002:a17:907:1dd3:b0:730:9340:a0a with SMTP id og19-20020a1709071dd300b0073093400a0amr4391666ejc.316.1659687004740;
        Fri, 05 Aug 2022 01:10:04 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id t18-20020aa7d4d2000000b0043a2b8ab377sm1662793edr.88.2022.08.05.01.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 01:10:03 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <40fdfb11-1e40-a36a-d3a4-fcbef546a78a@redhat.com>
Date:   Fri, 5 Aug 2022 10:10:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] hw/i386: place setup_data at fixed place in memory
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, qemu-devel@nongnu.org
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Laszlo Ersek <lersek@redhat.com>, linux-efi@vger.kernel.org
References: <YuxOgtykRQb1HU3e@zx2c4.com>
 <20220804230411.17720-1-Jason@zx2c4.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220804230411.17720-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/5/22 01:04, Jason A. Donenfeld wrote:
> +    /* Nothing else uses this part of the hardware mapped region */
> +    setup_data_base = 0xfffff - 0x1000;

Isn't this where the BIOS lives?  I don't think this works.

Does it work to place setup_data at the end of the cmdline file instead 
of having it at the end of the kernel file?  This way the first item 
will be at 0x20000 + cmdline_size.

Paolo
