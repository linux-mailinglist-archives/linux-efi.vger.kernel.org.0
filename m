Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D278B56BAAB
	for <lists+linux-efi@lfdr.de>; Fri,  8 Jul 2022 15:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbiGHN3X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Jul 2022 09:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237419AbiGHN3W (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 8 Jul 2022 09:29:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063902CC89;
        Fri,  8 Jul 2022 06:29:22 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0DA7366019BD;
        Fri,  8 Jul 2022 14:29:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657286960;
        bh=kYuvuzoKyfF8He1pBh2mVcn/g+3TU24CLCFthngUncQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UtRVuGZTETFIO5meZShAMsL+bwK2NYecNGPsBKytgct9kclAQTpVCfMfWaMj2813Q
         Mt8Q1CzMLQchmPKZolQ5UJ6BL3bM4c4W7nr5vfLoBxxt/P+8r6KaZrLHs74hj6eYJE
         Gy2ZfJ52iQ6Fzoxzl13jACyO0eT6MFGWu713IpcTOXmYF9tEaje7KcPRTipBNJQfbJ
         t1hHajALHFUQ10L1iYC4B1c3CQZdQDA+4+V/imfNFwvKThS2PJlSV4vHS9d2vCkjHQ
         ABqfLyYXwUYNPRKOq2UJXiYqqvLvJmBzpm+9qaknDL2kS6WSUJ3UKACOMKaIXVGRTi
         0k3bD7L/xwKSw==
Message-ID: <e6dccc45-5b69-dd65-a3dc-88a219fb238e@collabora.com>
Date:   Fri, 8 Jul 2022 16:29:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/2] Fix 2 5.19 power-off regressions caused by
 sys-off-handler work
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org
References: <20220708131412.81078-1-hdegoede@redhat.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220708131412.81078-1-hdegoede@redhat.com>
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

On 7/8/22 16:14, Hans de Goede wrote:
> Hi All,
> 
> I noticed that my Lenovo Yoga Tablet 2 1050L was hanging on power-off again
> with 5.19, even though I had implemented a workaround for this in 5.17 .
> 
> I quickly realized that this was caused by the recent sys-off-handler work
> and fixed this by switching the workaround over to register_sys_off_handler
> with a priority of SYS_OFF_PRIO_FIRMWARE + 1, so that the workaround runs
> before acpi_power_off() get a chance to run.
> 
> This made me realize that the efi_power_off handler which sometimes is
> used in preference of acpi_power_off had the same problem, so the second
> patch in this series fixes that.
> 
> I plan to include patch 1/2 in a fixes pull-req to Linus soon. Ard,
> if I can get your Ack for 2/2 then I can include this in the pull-req
> if you want; or you can send this to Linus yourself.
> 
> Regards,
> 
> Hans
> 
> 
> Hans de Goede (2):
>   platform/x86: x86-android-tablets: Fix Lenovo Yoga Tablet 2 830/1050
>     poweroff again
>   efi: Fix efi_power_off() not being run before acpi_power_off() when
>     necessary
> 
>  drivers/firmware/efi/reboot.c              | 21 +++++++++++----------
>  drivers/platform/x86/x86-android-tablets.c | 17 +++++++++++++----
>  2 files changed, 24 insertions(+), 14 deletions(-)
> 

Thank you for the fixes. It's great that the RC is getting more testing
since I couldn't test everything and we don't have CI for the power-off
testing.

-- 
Best regards,
Dmitry
