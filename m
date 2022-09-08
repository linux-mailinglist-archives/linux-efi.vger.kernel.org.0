Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C37B5B175C
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 10:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiIHImV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 04:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiIHImV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 04:42:21 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD20A3D5D
        for <linux-efi@vger.kernel.org>; Thu,  8 Sep 2022 01:42:19 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 4717140737B6;
        Thu,  8 Sep 2022 08:42:13 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 08 Sep 2022 11:42:13 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     chen zhang <chenzhang@kylinos.cn>
Cc:     ardb@kernel.org, ilias.apalodimas@linaro.org,
        chenzhang_0901@163.com, linux-efi@vger.kernel.org
Subject: Re: [PATCH] efi/x86: libstub: remove unused variables
In-Reply-To: <20220907023255.35237-1-chenzhang@kylinos.cn>
References: <20220907023255.35237-1-chenzhang@kylinos.cn>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <ba9c545066d80740df279a34c4fa795a@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-09-07 05:32, chen zhang wrote:
> The variable "has_system_memory" is unused in
> function ‘adjust_memory_range_protection’, remove it.
> 

Thanks for pointing out.
Will change that in v2.

Thanks,
Evgeniy Baskov
