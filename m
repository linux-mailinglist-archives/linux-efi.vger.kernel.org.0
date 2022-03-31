Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5BD4EDC12
	for <lists+linux-efi@lfdr.de>; Thu, 31 Mar 2022 16:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbiCaOwD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Mar 2022 10:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237824AbiCaOwC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Mar 2022 10:52:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 523C95576F
        for <linux-efi@vger.kernel.org>; Thu, 31 Mar 2022 07:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648738214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4syl0TwIcCPylaIS1VmorYj2ruIeY8S5BvvyNsDOjJk=;
        b=V7WtrAS/Foef8vRjtsF1csR6izx4g0rYc1Y6hEdz5Vgc/8XmKhEurgkbyIexvzJKoxtRHo
        u03IaYK8iqfkzdIr59ojKOFXWdZAdySfVicuaBpMdD5QckYe8NIp9iFImrgAYmqETHPZUs
        upO8X3+kvXX0yP7L87IaMP7R0NLwHyM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-SQsfyPJBOvi8kIlS6lW2_Q-1; Thu, 31 Mar 2022 10:50:13 -0400
X-MC-Unique: SQsfyPJBOvi8kIlS6lW2_Q-1
Received: by mail-wm1-f72.google.com with SMTP id q6-20020a1cf306000000b0038c5726365aso1249290wmq.3
        for <linux-efi@vger.kernel.org>; Thu, 31 Mar 2022 07:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4syl0TwIcCPylaIS1VmorYj2ruIeY8S5BvvyNsDOjJk=;
        b=oNNaq/WjX77gGWsM+Bf8i+jJ7rVhlZyk3uxCsAOVYE1o5y1fugriOQy5DknIJficyu
         RXUSCfJMXHmCaXxFlHCK7zqLDC7Fle9Kj7HYk0GVaBvWyqnq0iGn5dinfYgEFsSW29KN
         BJKQMXMdOxZi2tyghGbmrbLj5XvffRsz+pgKrF/dhohj/rSuZcgkRsf3/guqCDJj1yge
         ohUBz4BtYm43OSgBfcYfsvt3bFAGnGt0/hQ5jEw1lPRbk7YURd+4e7phf+aC4LZBFPrC
         K/2T5z76NrzX65gROnlTUEiq/Ef9BPoh29OBTVWlei3BHPTwcqNGKoCIbeb7Vz54aSDQ
         V7Lg==
X-Gm-Message-State: AOAM532H+7W99YMDVnQz1Mj1Crg+M0IESoe5bvJyWN4rdgmLIVbI3q5h
        CurhZjZHu+3bTCAjzpjBoThtELamEoTyFj1GlRd7J5CHmVhkSmKroVjas0ieq0BUn3mPlr08n89
        nybHr0ZN1gb1PJvYKIYtE
X-Received: by 2002:a05:600c:4f48:b0:38c:a460:cb6 with SMTP id m8-20020a05600c4f4800b0038ca4600cb6mr5110941wmq.96.1648738208917;
        Thu, 31 Mar 2022 07:50:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9T76Bw0cdtCwgENOVXbVuS/cZmvBb3Y3BI44bqjp7y5iekmFPLn5U6GIX8wGmn8RPjylCzQ==
X-Received: by 2002:a05:600c:4f48:b0:38c:a460:cb6 with SMTP id m8-20020a05600c4f4800b0038ca4600cb6mr5110912wmq.96.1648738208650;
        Thu, 31 Mar 2022 07:50:08 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p11-20020a5d638b000000b002048a77636dsm19369398wru.97.2022.03.31.07.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 07:50:08 -0700 (PDT)
Message-ID: <7178244c-fcfb-01d8-f678-565401cabca0@redhat.com>
Date:   Thu, 31 Mar 2022 16:50:06 +0200
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
 <ce8d975e-d9dd-f9b8-793d-234258021169@redhat.com>
 <YkW9T2xRSI9e4BFv@linutronix.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YkW9T2xRSI9e4BFv@linutronix.de>
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

On 3/31/22 16:40, Sebastian Andrzej Siewior wrote:
> On 2022-03-31 16:25:40 [+0200], Javier Martinez Canillas wrote:
>> Hello Sebastian,
> Hi Javier,
> 
>> Yes, it is but the motivation is to be able to have EFI runtime services
>> by default without the need for any kernel command line parameter.
> 
> This part wasn't clear. It is not mentioned by the description but now
> that I look at Kconfig, it is there.
>

Sure, I can post a v2 with better wording in the description to make it clear.
 
>> In the same vein, I could ask if efi=noruntime wasn't enough instead of
>> commit ("efi: Disable runtime services on RT").
> 
> No, it is not because it should not lead to any surprise latencies by
> default.
>

Yes, it was a rhetorical question. I understand the motivation of that commit
and agree with it. That's why $SUBJECT doesn't change the current behaviour,
and the EFI runtime services will still be disabled by default for RT.

It's just to allow a way to enable for RT users that may want to. But having
a separate boolean symbol also allow non RT users to disable it by default.
 
> Sebastian
> 

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

