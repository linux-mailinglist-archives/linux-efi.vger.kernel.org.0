Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958034EDBA5
	for <lists+linux-efi@lfdr.de>; Thu, 31 Mar 2022 16:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbiCaO1g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Mar 2022 10:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbiCaO1f (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Mar 2022 10:27:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23B4521D7DF
        for <linux-efi@vger.kernel.org>; Thu, 31 Mar 2022 07:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648736747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V/896Bc62YoXIkfH/P8P5pIpMY0pVJz3gsn8/xOqrGU=;
        b=ZlIH+xY4r1AEEVezjlik+SHTYhMKnwmTPIlgnLyBZTF6Wm9DlLgPNvx1VS4UWpSivrS624
        Oi2uUtn9rna+a0nO/NlfmkBY8CuMUNotAAyuadynIT+nuO3Wyon/9BQZKNFRiXXM/YaO9t
        jOGAdkcZpHM4JWo84p32lCXGVuDcB2A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-iJFKmnGQOrij7JSCTXgu4w-1; Thu, 31 Mar 2022 10:25:44 -0400
X-MC-Unique: iJFKmnGQOrij7JSCTXgu4w-1
Received: by mail-wm1-f70.google.com with SMTP id 9-20020a05600c240900b0038c99b98f6fso1239103wmp.0
        for <linux-efi@vger.kernel.org>; Thu, 31 Mar 2022 07:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V/896Bc62YoXIkfH/P8P5pIpMY0pVJz3gsn8/xOqrGU=;
        b=2UgOwHny9mQ7+q0j7Or2M6Pc/HmNJEqOV8t47cC5ik3A2N4FS2fSc/Ck5RK12x09rj
         xXjD+LTYnpZcylq/HzySyak5+x4nnCwIlsjjTNWdTuXPhsaNmBcCkVWxlWNJDOoKG5TA
         r7ODJMNy9hKW0ribz0SuvIWrz80Y5lde3lV9i8Vw04CebRpoRhLHPd/6GuPBuS4vxGLD
         6jV+mEz0abOGYMliq2KqwSK+YmNCERwzUBILkfkCEZvHsa/XHjdn5aAezsWI1koZ/Fil
         gtGjIFFMZ7MWG2Zuy1CFOFDlS664wGvIOmzP8RVAq9/b3BunON8YBss91ybUmP/Pd8b9
         yq7A==
X-Gm-Message-State: AOAM530WdaDOdjB7XpQkOReW0VLY4ptmKEOmQuz/BmvOlLRep9DvW6ab
        gCdJiQELlupnCwNpFz247YgWyTV5JA9eviyZfHzRg2CdK3hQlgQyp6dsk2RAUYLP749Lt61RhLe
        hmQ4I8qSoL2lxsaU/lK4l
X-Received: by 2002:a05:600c:4f10:b0:38c:ae36:d305 with SMTP id l16-20020a05600c4f1000b0038cae36d305mr5062036wmq.34.1648736743462;
        Thu, 31 Mar 2022 07:25:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+nCts91Ox2v33cXyUxStj+G8bKWgtO7ypFuFQU85nR93l+pGlLswqWvSuB4F5iAFTSK9ljg==
X-Received: by 2002:a05:600c:4f10:b0:38c:ae36:d305 with SMTP id l16-20020a05600c4f1000b0038cae36d305mr5062017wmq.34.1648736743225;
        Thu, 31 Mar 2022 07:25:43 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm12809273wmq.27.2022.03.31.07.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 07:25:41 -0700 (PDT)
Message-ID: <ce8d975e-d9dd-f9b8-793d-234258021169@redhat.com>
Date:   Thu, 31 Mar 2022 16:25:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] efi: Allow to enable EFI runtime services with PREEMPT_RT
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Al Stone <ahs3@redhat.com>, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        linux-rt-users@vger.kernel.org, Brian Masney <bmasney@redhat.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220331141038.171204-1-javierm@redhat.com>
 <YkW3EmURxE1+kOu5@linutronix.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YkW3EmURxE1+kOu5@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Sebastian,

On 3/31/22 16:13, Sebastian Andrzej Siewior wrote:
> On 2022-03-31 16:10:38 [+0200], Javier Martinez Canillas wrote:
>> Commit d9f283ae71af ("efi: Disable runtime services on RT") disabled EFI
>> runtime services when the CONFIG_PREEMPT_RT option is enabled.
>>
>> The rationale for the change is that some EFI calls could take too much
>> time, leading to large latencies which are an issue for RT kernels.
>>
>> But a side effect of that commit is that now is not possible anymore to
>> enable the EFI runtime services by default when CONFIG_PREEMPT_RT is set
>> to y, even for platforms that could guarantee bounded time for EFI calls.
>>
>> Instead, let's add a new EFI_DISABLE_RUNTIME boolean Kconfig option, that
>> would be set to n by default but to y if CONFIG_PREEMPT_RT is enabled.
>>
>> That way, the current behaviour is preserved but gives users a mechanism
>> to enable the EFI runtimes services in their kernels if that is required.
> 
> Is the command line switch
> 	efi=runtime
> 
> not working?
>

Yes, it is but the motivation is to be able to have EFI runtime services
by default without the need for any kernel command line parameter.

In the same vein, I could ask if efi=noruntime wasn't enough instead of
commit ("efi: Disable runtime services on RT").

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

