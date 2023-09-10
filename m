Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E73799FE0
	for <lists+linux-efi@lfdr.de>; Sun, 10 Sep 2023 22:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjIJUm4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 10 Sep 2023 16:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjIJUm4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 10 Sep 2023 16:42:56 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD1F18B
        for <linux-efi@vger.kernel.org>; Sun, 10 Sep 2023 13:42:50 -0700 (PDT)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3905D3F5DC
        for <linux-efi@vger.kernel.org>; Sun, 10 Sep 2023 20:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694378569;
        bh=dIKR3XWD4VYgjlaXcyWAps8H+mMXxRwpbn+AsBDDcdo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=kDH9w3Bg/MLZZ7MbqJ/sDiyZ3VImMHvENP/G6wNnbD2netSHzEcAgI/LbWCuSU5/9
         4lOTQdVo03HlIto1sps1wCH2RM/hG+Oajhh/gVCb8h5HRiNd2RbfiHkDbrLKCrI/pP
         Mf1Q09vVfTdjqdXIESq9JnRlP0pKnWSu6DpNVncanvF8elnwkpCzzkKWzLr2srmATq
         mAUT2IMg+9MzNk+4+8jSP5GtJNBS3yYx7jAXVBBY+iqpK6tV1lVRNVH+LetBXXoMkP
         aFV34GmqvlHr4V/8Oe72QkVu4XqJ11FHF2QMQg2oKO1VKfllEdCPPDnXdpHJCsnbpl
         8pdL+bLEDhaTA==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-2f2981b8364so2456329f8f.1
        for <linux-efi@vger.kernel.org>; Sun, 10 Sep 2023 13:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694378568; x=1694983368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIKR3XWD4VYgjlaXcyWAps8H+mMXxRwpbn+AsBDDcdo=;
        b=nCGTxTE1rSCpOZ7xRMCXvqVYxGMcp1IIXsY5vQwPSYk1b+yJKvvdjBufC0l7Cnl1Vz
         LMCnUVsW82igouptyaPcqr8mptN6hTCdVrhesMn6ygAsymuO9kgqPdS8Q+KpYkJEf0/F
         EMmazxhArXIvoEU6+PXKsYmT5u4xbXsfKjAch2V3HtK8HhEFHiPzWVblXvDz4dEvGm0b
         6ea5Ilunj5SxXf/F9pg37FL1kNRS3nlBxMQkP+TwpB1T2McePa/91Njjo1h9JqXeP68H
         /JY8nGt/FIF5zbdHphT1uE0g2AvG9fa/3bVj9kreW+gQGWCyzOfUUgfXE7UHFeaSMCw+
         9yIQ==
X-Gm-Message-State: AOJu0YxNoQUJu/Jmk+Tx64rxM2llt0KTj816XqadH6P8S/SHQzT9klY8
        0o5RiymLV+lJrOktGPpyWQRwAq4/dcBa9kHOOyCC7OPMt3ZJLeWFqdUvLdRHE64i2xQdQGRJDce
        7RLnlKljLu/G+1iFv89rMD2PG8AQPLAeEZ6BBlg==
X-Received: by 2002:adf:a449:0:b0:31f:9bdb:79fc with SMTP id e9-20020adfa449000000b0031f9bdb79fcmr1987099wra.31.1694378568237;
        Sun, 10 Sep 2023 13:42:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp9RaQx2/VAgQoFjWaEWyqS3W/rmPumYYsAuwg77HqgmN3uLYFl7RqU517GMDx/241A4ohcg==
X-Received: by 2002:adf:a449:0:b0:31f:9bdb:79fc with SMTP id e9-20020adfa449000000b0031f9bdb79fcmr1987094wra.31.1694378567898;
        Sun, 10 Sep 2023 13:42:47 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
        by smtp.gmail.com with ESMTPSA id x5-20020a5d54c5000000b0031773a8e5c4sm8075309wrv.37.2023.09.10.13.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 13:42:47 -0700 (PDT)
Message-ID: <1bc137b6-6006-42cd-9f6d-c523fc753d63@canonical.com>
Date:   Sun, 10 Sep 2023 22:43:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] efivarfs: fix statfs() on efivarfs
To:     Anisse Astier <anisse@astier.eu>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
        Anisse Astier <an.astier@criteo.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
References: <20230910045445.41632-1-heinrich.schuchardt@canonical.com>
 <ZP4QEvhzO5cOt6lT@gpdmax>
Content-Language: en-US
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <ZP4QEvhzO5cOt6lT@gpdmax>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/10/23 20:53, Anisse Astier wrote:
> Hi Heinrich,
> 
> On Sun, Sep 10, 2023 at 06:54:45AM +0200, Heinrich Schuchardt wrote:
>> Some firmware (notably U-Boot) provides GetVariable() and
>> GetNextVariableName() but not QueryVariableInfo().
> 
>  From a quick search, it seems u-boot, does support QueryVariableInfo, is
> it on a given version ?
> 
> https://elixir.bootlin.com/u-boot/v2023.07.02/source/lib/efi_loader/efi_variable.c#L391

QueryVariableInfo() and SetVariable() are available before 
ExitBootServices(), i.e. in Linux' EFI stub.

ExitBootServices() results in calling efi_variables_boot_exit_notify() 
which disables these services during the UEFI runtime.

> 
>>
>> With commit d86ff3333cb1 ("efivarfs: expose used and total size") the
>> statfs syscall was broken for such firmware.
> 
> Could you be more specific ? What breaks, and what regressed ? I imagine
> it could be some scripts running df, but maybe you had something else in
> mind ?

Some more details can be found in 
https://bugs.launchpad.net/ubuntu/+source/linux-meta-riscv/+bug/2034705.

Though EFI variables are exposed via GetVariable() and 
GetNextVariableName() the efivar command refuses to display variables 
when statfs() reports an error.

> 
>>
>> If QueryVariableInfo() does not exist or returns an error, just report the
>> file-system size as 0 as statfs_simple() previously did.
> 
> I considered doing this [2] , but we settled on returning an error
> instead for clarity:
> https://lore.kernel.org/linux-efi/20230515-vorgaben-portrait-bb1b4255d31a@brauner/
> 
> I still think it would be a good idea if necessary.

We should never break user APIs.

> 
> On the approach, I prefer what Ard proposed, to fall back to the old
> approach. I think the difference in block size could also be a good
> marker that something wrong is happening:
> https://lore.kernel.org/linux-efi/CAMj1kXEkNSoqG4zWfCZ8Ytte5b2SzwXggZp21Xt17Pszd-q0dg@mail.gmail.com/

This will allow user code making assumptions based on block size:
If block size > 1, assume setting variables is possible.

We should really avoid this.

Best regards

Heinrich

