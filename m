Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FF956BAFF
	for <lists+linux-efi@lfdr.de>; Fri,  8 Jul 2022 15:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbiGHNg6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Jul 2022 09:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbiGHNg5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 8 Jul 2022 09:36:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B8D1D312;
        Fri,  8 Jul 2022 06:36:57 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3EBC666019BD;
        Fri,  8 Jul 2022 14:36:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657287416;
        bh=uGsFBhHc9kJWk3WsIFFI61YBmGvbTRXKlcjd/9PjAq4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DS9pf2KztkBHA3zmK8czLuFCzxQkTopMbjqIMeSgl+9qwWFHDQzfAxnNcYNHERx6q
         cKlVmHGzJDJWXNmi6bOw1yQqCGiEbaTcVB5jp5rRZQJwzHhVRSTtnmQ55AJUBq0voh
         pQEnFcfAGvXpE98f3kCaPATOC9lCFqj7M+/NpRtmGQ5k9dtBkxVjXVQcl5wCLKHHi+
         GFqqE6kYqFMuHIsJIxwv7VAssf6KYqUtZnFZaYHGH5Z6uJM6TMzWncpZrs19LoYIH8
         Rz1HS6Si9Jg8wLwCnO6b7HOaEH+Y8xadUVEVhQMYXimM2j+0Ah235a6QZc8ivAuq8f
         VU1u/z4liIeJg==
Message-ID: <f7ad68fa-7a32-d89b-efbd-2c056ed0999d@collabora.com>
Date:   Fri, 8 Jul 2022 16:36:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] platform/x86: x86-android-tablets: Fix Lenovo Yoga
 Tablet 2 830/1050 poweroff again
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
 <20220708131412.81078-2-hdegoede@redhat.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220708131412.81078-2-hdegoede@redhat.com>
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
> @@ -950,13 +953,19 @@ static int __init lenovo_yoga_tab2_830_1050_init(void)
>  	if (ret)
>  		return ret;
>  
> -	pm_power_off = lenovo_yoga_tab2_830_1050_power_off;
> +	/* SYS_OFF_PRIO_FIRMWARE + 1 so that it runs before acpi_power_off */
> +	lenovo_yoga_tab2_830_1050_sys_off_handler =
> +		register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_FIRMWARE + 1,
> +					 lenovo_yoga_tab2_830_1050_power_off, NULL);
> +	if (IS_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler))
> +		return PTR_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler);

Please note that technically we could ignore the registration error
(maybe print error message) and allow the rest of the module to work
without the power-off.

The unregister_sys_off_handler() will skip the ERR_PTR handler.

-- 
Best regards,
Dmitry
