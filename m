Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58FEFAC7B1
	for <lists+linux-efi@lfdr.de>; Sat,  7 Sep 2019 18:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391371AbfIGQpy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 7 Sep 2019 12:45:54 -0400
Received: from mail.grenz-bonn.de ([178.33.37.38]:56781 "EHLO
        mail.grenz-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390693AbfIGQpy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 7 Sep 2019 12:45:54 -0400
X-Greylist: delayed 444 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Sep 2019 12:45:53 EDT
Received: from [192.168.43.69] (unknown [213.55.221.144])
        by ks357529.kimsufi.com (Postfix) with ESMTPSA id 3C95A96291;
        Sat,  7 Sep 2019 18:38:26 +0200 (CEST)
Subject: Re: Black screen regression introduced in: efi: Refactor
 efi_memmap_init_early() into arch-neutral code
From:   =?UTF-8?Q?Niklas_Hamb=c3=bcchen?= <mail@nh2.me>
To:     linux-efi <linux-efi@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>
Cc:     Dave Young <dyoung@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Peter Jones <pjones@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Mark Rutland <mark.rutland@arm.com>
References: <0500ae5b-1a3f-237a-e3ee-885704dbe95a@nh2.me>
Openpgp: preference=signencrypt
Autocrypt: addr=mail@nh2.me; prefer-encrypt=mutual; keydata=
 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
Message-ID: <bbcfd57e-dc39-2d13-03df-e0f5e37e6162@nh2.me>
Date:   Sat, 7 Sep 2019 18:38:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0500ae5b-1a3f-237a-e3ee-885704dbe95a@nh2.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

For posterity, a patch was posted that solves my problem:

https://bugzilla.kernel.org/show_bug.cgi?id=203463#c8
