Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6E55B442E
	for <lists+linux-efi@lfdr.de>; Sat, 10 Sep 2022 06:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiIJE45 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 10 Sep 2022 00:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIJE44 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 10 Sep 2022 00:56:56 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296CBB9404
        for <linux-efi@vger.kernel.org>; Fri,  9 Sep 2022 21:56:54 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id WsXsooWDfez1rWsXsoPi6u; Sat, 10 Sep 2022 06:56:52 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 10 Sep 2022 06:56:52 +0200
X-ME-IP: 90.11.190.129
Message-ID: <04d65bd7-a6b2-bb14-fd69-632542ae9e86@wanadoo.fr>
Date:   Sat, 10 Sep 2022 06:56:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] efi: efibc: Guard against allocation failure
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, linux-kernel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        matt@codeblueprint.co.uk, mjg59@srcf.ucam.org
References: <20220909194214.186731-1-gpiccoli@igalia.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220909194214.186731-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Le 09/09/2022 à 21:42, Guilherme G. Piccoli a écrit :
> There is a single kmalloc in this driver, and it's not currently
> guarded against allocation failure. Do it here by just bailing-out
> the reboot handler, in case this tentative allocation fails.
> 
> Fixes: 416581e48679 ("efi: efibc: avoid efivar API for setting variables")
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> V2:
> * Rebased against 6.0-rc4;
> * Dropped from the original series [0].
> 
> [0] https://lore.kernel.org/linux-efi/20220729194532.228403-1-gpiccoli@igalia.com/
> 
> 
>   drivers/firmware/efi/efibc.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/firmware/efi/efibc.c b/drivers/firmware/efi/efibc.c
> index 8ced7af8e56d..4f9fb086eab7 100644
> --- a/drivers/firmware/efi/efibc.c
> +++ b/drivers/firmware/efi/efibc.c
> @@ -48,6 +48,9 @@ static int efibc_reboot_notifier_call(struct notifier_block *notifier,
>   		return NOTIFY_DONE;
>   
>   	wdata = kmalloc(MAX_DATA_LEN * sizeof(efi_char16_t), GFP_KERNEL);
Hi,

even if mostly useless in this case, kmalloc_array()?

Or certainly maybe even better, kstrndup()?

CJ

> +	if (!wdata)
> +		return NOTIFY_DONE;
> +
>   	for (l = 0; l < MAX_DATA_LEN - 1 && str[l] != '\0'; l++)
>   		wdata[l] = str[l];
>   	wdata[l] = L'\0';

