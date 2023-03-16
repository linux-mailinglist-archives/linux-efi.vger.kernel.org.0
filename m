Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F295B6BC7D4
	for <lists+linux-efi@lfdr.de>; Thu, 16 Mar 2023 08:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjCPHzJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Mar 2023 03:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjCPHzG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Mar 2023 03:55:06 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CCD2D5C
        for <linux-efi@vger.kernel.org>; Thu, 16 Mar 2023 00:54:53 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D42E544604
        for <linux-efi@vger.kernel.org>; Thu, 16 Mar 2023 07:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678953291;
        bh=qGt0tprnwW2zEB3q8ctGt6HU/4xBmHY46SHmJifIh80=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type;
        b=h9boqRn1rbMoOC8PGcqwGKIjYLnGw3oVGcZqWHqvS2kKNMdfu7Dt3yuguRICFM8th
         CYZF6TuFjwIhp0gjq7dL72NaZNjwLUhXMH764f2oUzyuA+QBJ0o30N9EzGZhv/mT4U
         ONlcjs8jofDUZ0MMZr3yynEe/+FBZEdlv8VoL5T1+42SYIJoH7POXGwm6THXwsVGCC
         Zfe8SLGCz8wdZOGmGjLfiOjZQb6KlLtv8E6UuwVW4dRHFP8lEX7Ybtnb/UDCLEnGpH
         JXXPEa8Uuxs9g5fxu+w0DSLvypaGYBhRwkIsNF+6o3nYtekSuQ+G0F1iwcYxGUgzXM
         71GFVMMoPR/1g==
Received: by mail-ed1-f70.google.com with SMTP id e18-20020a056402191200b004fa702d64b3so1778848edz.23
        for <linux-efi@vger.kernel.org>; Thu, 16 Mar 2023 00:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678953291;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGt0tprnwW2zEB3q8ctGt6HU/4xBmHY46SHmJifIh80=;
        b=22DP7scLPMKJ1kP2pvVOct5UTBK+JQVh0XT1e6Pg/qmafdsAI4d5PZTwBrdbs0gOOY
         ViFwZh1b+yRpukmP9WnVApfr2u3BLHb72KXXiCbbWfgJmdJ6i9frIIfTPxmQLHpQPwKG
         F2iddSbNCqJTBZ/JbLZTLtq/pqD+tpWxqouRJ4zO4guwrvnfcOMyC4CByhUAd5bdVDIe
         bqTzXHx2r7kNmv+6D1/1k56FIqJsn8DgCCNtTzp06Fh2fPq+sxiOxrpM1qjfaSyrpl2M
         f01AiT0MbIKpqvWNr/QY/BJWv8/az3txm7xBKu8pO2+qEgIqjtjDWIa/piwk7KrmynGR
         bkMQ==
X-Gm-Message-State: AO0yUKUBk5QWoEe1QtncaRddnT/qQoK0vvAA9a5Hrb0wUEfOHNsUwsBq
        fCj+tTuKDrDcP9QHT6rGmCWYfR/S68felMZlPpdvi7hzTL71u7DFpBLLkYNW7w7H2YEycZYT5tm
        0DSH3MhXz6BfNhr4TLoyQk5zIm18pRsTSF61f/Q==
X-Received: by 2002:a17:906:7d52:b0:92e:e9c2:7b9e with SMTP id l18-20020a1709067d5200b0092ee9c27b9emr4072726ejp.41.1678953291478;
        Thu, 16 Mar 2023 00:54:51 -0700 (PDT)
X-Google-Smtp-Source: AK7set+FETcLexrDXYMvk89c0e7LpTs0E4JC/3xwt/aeNO69wTMJybT7QpGtj8/8qjNoOYM+o7ZtPA==
X-Received: by 2002:a17:906:7d52:b0:92e:e9c2:7b9e with SMTP id l18-20020a1709067d5200b0092ee9c27b9emr4072712ejp.41.1678953291197;
        Thu, 16 Mar 2023 00:54:51 -0700 (PDT)
Received: from localhost (host-79-53-23-214.retail.telecomitalia.it. [79.53.23.214])
        by smtp.gmail.com with ESMTPSA id e20-20020a50d4d4000000b004fbf6b35a56sm3412754edj.76.2023.03.16.00.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 00:54:50 -0700 (PDT)
Date:   Thu, 16 Mar 2023 08:54:50 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: kernel 6.2 stuck at boot (efi_call_rts) on arm64
Message-ID: <ZBLLSmLbt2P4ZN6O@righiandr-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello,

the latest v6.2.6 kernel fails to boot on some arm64 systems, the kernel
gets stuck and never completes the boot. On the console I see this:

[   72.043484] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   72.049571] rcu:     22-...0: (30 GPs behind) idle=b10c/1/0x4000000000000000 softirq=164/164 fqs=6443
[   72.058520]     (detected by 28, t=15005 jiffies, g=449, q=174 ncpus=32)
[   72.064949] Task dump for CPU 22:
[   72.068251] task:kworker/u64:5   state:R  running task     stack:0     pid:447   ppid:2      flags:0x0000000a
[   72.078156] Workqueue: efi_rts_wq efi_call_rts
[   72.082595] Call trace:
[   72.085029]  __switch_to+0xbc/0x100
[   72.088508]  0xffff80000fe83d4c

After that, as a consequence, I start to get a lot of hung task timeout traces.

I tried to bisect the problem and I found that the offending commit is
this one:

 e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")

I've reverted this commit for now and everything works just fine, but I
was wondering if the problem could be caused by a lack of entropy on
these arm64 boxes or something else.

Any suggestion? Let me know if you want me to do any specific test.

Thanks,
-Andrea
