Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8355F4EE9D6
	for <lists+linux-efi@lfdr.de>; Fri,  1 Apr 2022 10:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243577AbiDAIki (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 1 Apr 2022 04:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243415AbiDAIkh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 1 Apr 2022 04:40:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23A7935875
        for <linux-efi@vger.kernel.org>; Fri,  1 Apr 2022 01:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648802327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jJgRufLo0Q+2TohvSo0V+grK8YPgHhb39pNmOaDe4X4=;
        b=i1dUZuYYAqVSCyGEIlEn33F1du42TT2bGzKH2NGRzYwclcIFEsFMj6+/OA/RfSo3GacZbk
        Im/lbOygJA9YGMJkucVlIOJ7ZZMbmTKSg9/ME8lL+5DcmmatUDaHm+q724dVVKvN42Q/Bz
        ODM7agVwqiAfBpwzgCqXBWgP9r/UNOQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-PP3xieJFNgqVlAljtLQ6aA-1; Fri, 01 Apr 2022 04:38:46 -0400
X-MC-Unique: PP3xieJFNgqVlAljtLQ6aA-1
Received: by mail-wm1-f69.google.com with SMTP id 9-20020a05600c240900b0038c99b98f6fso910348wmp.0
        for <linux-efi@vger.kernel.org>; Fri, 01 Apr 2022 01:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jJgRufLo0Q+2TohvSo0V+grK8YPgHhb39pNmOaDe4X4=;
        b=6GrB4HmcL2AIwMHgu+84CPnvUzrtU9LqxTkHcd1trWCFOHfDjfWpJNJ0x/z8lkUYVX
         orXgE8i7f+/4mkCpYnWBjnDg3yojr3slRxWscNNCosMj1OCXuOD0BVqP+hzrZg+gGZBo
         Iiv8EgADuy0t2UKYwgdd5w1ziI+vboEcK5QfRXL+4jd8ggYd3DWmX2ic0z9fpcdbCSxM
         NuwlxYKV4RZKuP5gnn7jsoZnCvc40crkv2q83mxFxPpA4uXCDn4Ckxpc80ODh7fwRVT+
         dEYYjRsFey91dtD+5edlbIBUuWAdX/7Qduc+TYIhj0/rH9ofP0CGYcFsbF1umBeIgTyH
         POUQ==
X-Gm-Message-State: AOAM532a6ljeF7OtCDK59WC6gN0nuldORh2vkZlo0sEwBMbn1BflbQVf
        sh3c9VK2aXgjCPXuRGMKFToOJBiMC9qbnqCs56IoQcJlWfxb6rlYz3iwjrq3XBxTyOzjXqCcUP/
        8tf/SQRq70Qkb3Cdjq0x5
X-Received: by 2002:a05:600c:20a:b0:38c:95bf:3289 with SMTP id 10-20020a05600c020a00b0038c95bf3289mr7846164wmi.134.1648802324837;
        Fri, 01 Apr 2022 01:38:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZv6I0FVV+CMTD5Ii7q1vvCTUGk/jp2epbACrhoZA7VwhBmVuCWWnjWAfbB1yDcm4RVzFGLA==
X-Received: by 2002:a05:600c:20a:b0:38c:95bf:3289 with SMTP id 10-20020a05600c020a00b0038c95bf3289mr7846142wmi.134.1648802324598;
        Fri, 01 Apr 2022 01:38:44 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l126-20020a1c2584000000b00387d4f35651sm9408352wml.10.2022.04.01.01.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 01:38:44 -0700 (PDT)
Message-ID: <19fa075a-cc5a-4127-389a-bab7812d7af3@redhat.com>
Date:   Fri, 1 Apr 2022 10:38:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] efi: Allow to enable EFI runtime services by default
 on RT
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Brian Masney <bmasney@redhat.com>, Al Stone <ahs3@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220331151654.184433-1-javierm@redhat.com>
 <CAMj1kXHgyjB_BVzXx+CK0tBuJpZ3h=8XKus7nWiyovECjVQ0gw@mail.gmail.com>
 <YkYA/Wpqa/PMczkp@lx-t490>
 <CAFOAJEeKNy0HW82W6HV_49d5sc5L0m62QDfY9qA1906_ZzGRYg@mail.gmail.com>
 <Ykas9iX/D3WURx8T@linutronix.de>
 <78a0360d-1a27-5280-10bf-d27d1d306fa5@redhat.com>
 <CAMj1kXGEBtcdD+3MFK5gO6vCw8dg=ruTthdWGVUu1eJpgZXf8Q@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMj1kXGEBtcdD+3MFK5gO6vCw8dg=ruTthdWGVUu1eJpgZXf8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Ard,

On 4/1/22 10:34, Ard Biesheuvel wrote:
> On Fri, 1 Apr 2022 at 10:33, Javier Martinez Canillas
> <javierm@redhat.com> wrote:

[snip]

>>
>>         if (!efi_enabled(EFI_RUNTIME_SERVICES))
>>                 efi.runtime_supported_mask = 0;
>> +       else if (IS_ENABLED(CONFIG_PREEMPT_RT))
>> +               pr_warn("EFI runtime services can lead to high latencies on Real-Time kernels\n");
>>
>>         if (!efi_enabled(EFI_BOOT))
>>                 return 0;
>>
> 
> 
> I don't think we need another warning.
> 
> The kernel log already tells you whether or not EFI runtime services
> are enabled.
> 

I'm fine with this too. As mentioned to Ahmed I was torn on this, since I
understand the ask for the warning but also don't want to pollute the log.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

