Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BC35BEC4F
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 19:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiITRsK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 13:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiITRsI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 13:48:08 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFDB6A4B0;
        Tue, 20 Sep 2022 10:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0CNyhgjqHGopBqoqbBZ8Yju/2O3NXshXzEfEQ/3FlNg=; b=L1OFZLylTUYyLlJde2HvvVFqsY
        gYmYv3Ao/NyIoTCUofzCtBKBWeBvWrBKd8wVQHD+E6OwUZXGQUIJ8AkVmKqDDa9kA3SOUaGUCCvhQ
        +ulg1gRwB4BFUZM9m9HqoS+2C1CfmIM4MIE2ZgyajvBQhSaTxafUydWRfqLJLX37UkkoOGXQKINM+
        sBuKWPvzdS1RhD3qFjBLkFP7dkn3GG78BQEpsh0H0BcKIFywsuQ2GSin4KntlSm8NKDSp+8e/28oP
        Tfq/Y1AXXwFKdwBOhB43k2y49/ariwBG1ThPI/enkrC07ElFaebJEkDJBFKMfV1NlMOjJezp3oIGS
        cSu2/+dw==;
Received: from 201-13-158-146.dial-up.telesp.net.br ([201.13.158.146] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oahLg-00E5ow-Sh; Tue, 20 Sep 2022 19:47:56 +0200
Message-ID: <f45f7644-7e21-e9fe-f882-16b27c55c4d8@igalia.com>
Date:   Tue, 20 Sep 2022 14:47:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V2] efi: efibc: Guard against allocation failure
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        matt@codeblueprint.co.uk, mjg59@srcf.ucam.org
References: <20220909194214.186731-1-gpiccoli@igalia.com>
 <04d65bd7-a6b2-bb14-fd69-632542ae9e86@wanadoo.fr>
 <e8ce8fb4-baac-b3a5-5d6d-418e20c8d2d9@igalia.com>
 <CAMj1kXGze41X9ogZDEbm7=04XnFRPGjV7RMmeJnOveAsTfgDhQ@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAMj1kXGze41X9ogZDEbm7=04XnFRPGjV7RMmeJnOveAsTfgDhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 20/09/2022 13:44, Ard Biesheuvel wrote:
> [...]
> I've queued it as a fix - thanks.

Thanks Ard!
