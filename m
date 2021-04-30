Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D27936F6D6
	for <lists+linux-efi@lfdr.de>; Fri, 30 Apr 2021 10:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhD3IGv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Apr 2021 04:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhD3IGu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Apr 2021 04:06:50 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDCAC06174A
        for <linux-efi@vger.kernel.org>; Fri, 30 Apr 2021 01:06:01 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so251612wmh.4
        for <linux-efi@vger.kernel.org>; Fri, 30 Apr 2021 01:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=HngupYjGHm+hkQetGLmQpMnMPagu3iLRzXKi7rdQljE=;
        b=oXUzDOJZPXmdtZ9zd4K/HVK/y2K9Hr7kMG6/rsaqME0sNvTI/rA+zDfOkDWsEmXrGc
         EYIq9cqHGhjXtyx8y4uo5uT82SyaKj/hipMVavu0wVvGK48sQ2tQee/fONYYnNGN5D57
         6X7JVXGi4QDySVmdXWVxeKmCYQ1HRp1cDT1sNAPvxtjAHHcMHgEFLkgK7IiYJUdglbgR
         5s7nHmBn4ns2EUZCU+cKnkRJUJ71NK4u58/oIT3FhM4Eknz/WVrhsdNqMI0VMLZzcYIE
         Y3MB5p2WK41wLvIwXqhxrwZlnm8GRwd7ImtJEbwuw1laU6OkkZ5ogAFlPJ6w+daGPSHt
         69ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=HngupYjGHm+hkQetGLmQpMnMPagu3iLRzXKi7rdQljE=;
        b=X8tJEAhtnEJI0n9BCKMGtJnhkxDdwVbzIZ/kpDOV8Y7NREhCoYcrEytk5Acl8cUcPS
         5Ru7+YvyOklGUr5tBHGRLP7+/0HCrOl6ALmxn45qDQrfmX4YxnpHdiR042VRfX6b933F
         RjgBssNKn5iOClc2KI4bI5ulfrTmxxNFSaqoic3FqCZoMQrFjR7vwHToj89Mn6gjuc/c
         G98Mw/b+LDefglOLZFit5cs4b9TJ44nM51vWAZrlaCjb7/9dZ1mNl/atKC4Sep3+NH0k
         g1AucdEs3v4V+Pfkug82ZNY/e3eFvszKWTd2Fj87kVnP6jKnQQm/iMRvNgsZMUVU4Hhd
         U4Pg==
X-Gm-Message-State: AOAM533svZPpiwx9SbTLj2t8Cv+y29BRExTnlRfNyWYTzwf8zzvetz5I
        lznYSKzJhpcPF6q3g8gX7bcbGGqkEZuDZg==
X-Google-Smtp-Source: ABdhPJxHLi193AFHfgCtNV35zBmV3lbn7XXoIM84N4ZhIkeB7+959ZbneGS6ZesRK+OlGb2E3Cw6Pw==
X-Received: by 2002:a05:600c:41d4:: with SMTP id t20mr15544673wmh.46.1619769959842;
        Fri, 30 Apr 2021 01:05:59 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:ad00:f6bf:8c3b:84f1? (p200300ea8f384600ad00f6bf8c3b84f1.dip0.t-ipconnect.de. [2003:ea:8f38:4600:ad00:f6bf:8c3b:84f1])
        by smtp.googlemail.com with ESMTPSA id n2sm2829466wmb.32.2021.04.30.01.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 01:05:59 -0700 (PDT)
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Still required that EFI_MEMORY_XP and EFI_MEMORY_RO must not both be
 cleared?
Message-ID: <c32f0994-605c-3770-cda8-335acaa53c66@gmail.com>
Date:   Fri, 30 Apr 2021 10:05:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

I'm one of the people seeing the following warning:

efi: memattr: Entry attributes invalid: RO and XP bits both cleared
efi: memattr: ! 0x000000090000-0x000000090fff [Runtime Code|RUN|  |  |  |  |  |  |  |  |   |  |  |  |  ]

Out of curiosity I checked UEFI spec 2.9. On p.108 there's table 4.1:

                                                   EFI_MEMORY_RO EFI_MEMORY_XP EFI_MEMORY_RUNTIME
No memory access protection is possible for Entry  0             0             1
Write-protected Code                               1             0             1
Read/Write Data                                    0             1             1
Read-only Data                                     1             1             1

So it seems to be valid that both attributes are cleared.
Also in the surrounding text I didn't find a hint mandating
that at least one the attributes has to be set.
