Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F195B17F0
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 11:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiIHJDm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 05:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiIHJDm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 05:03:42 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D53A5702
        for <linux-efi@vger.kernel.org>; Thu,  8 Sep 2022 02:03:41 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 95FE240737B6;
        Thu,  8 Sep 2022 09:03:39 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 08 Sep 2022 12:03:39 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     chen zhang <chenzhang@kylinos.cn>, ilias.apalodimas@linaro.org,
        chenzhang_0901@163.com, linux-efi@vger.kernel.org
Subject: Re: [PATCH] efi/x86: libstub: remove unused variables
In-Reply-To: <CAMj1kXEVavPX6xHLs2zs4DTgfEHDeLweev9Z1NbAYJQPVBL4cA@mail.gmail.com>
References: <20220907023255.35237-1-chenzhang@kylinos.cn>
 <ba9c545066d80740df279a34c4fa795a@ispras.ru>
 <CAMj1kXFJHht=9r054cCKCzAjnSCrbRi9pD--XLNc-xrpHQnFBA@mail.gmail.com>
 <f0ca5dbabdd289fa14e0b0fe852b761c@ispras.ru>
 <CAMj1kXEVavPX6xHLs2zs4DTgfEHDeLweev9Z1NbAYJQPVBL4cA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <cabee0d55e47c96967ce40a3596a0dba@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-09-08 11:56, Ard Biesheuvel wrote:
> 
> But Chen Zhang already sent a patch that fixes this, so why bother?
> 
> I will queue this as a fix. Please rebase your patches on top if this
> causes a conflict.

Yes, I meant that I will rebase another series on top of this
change in v2. Sorry for the poor wording. (And not today, I guess)

Thanks,
Evgeniy Baskov
