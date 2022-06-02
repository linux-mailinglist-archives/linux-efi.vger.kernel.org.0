Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432D253BD6B
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jun 2022 19:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbiFBRki (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jun 2022 13:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiFBRkh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jun 2022 13:40:37 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FCB15C8BD;
        Thu,  2 Jun 2022 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=H4NUWnh4CNoxHFp6PxpI+HxUtMAzoOkc3EtPhdWILGQ=; b=QkL6ZCS4JGKg2HeBKLuWMRfuPU
        ij1qx4ElOxF4D8F5v++R/aJL8BfICwTl9kBI7lpbw8jwTR7+q2hu8NQQ1yQKn3YBtVBGrGZZLq7o0
        Ys0eqXZ6bOQhJ/AxBLC5KYGwdl4DGbCtkDAT8fqHu9PDWIiKJycBHST4GmBHeBKdmis4rQkO5BkuZ
        r6Vgs/x0qQ3tPsqZTcy2joOlQEZAl0IlhnXeEtHfLS9eud6zuAvP6TYCaRZVau62ILFu9iUF5sAvn
        5zdXeExClo6+YdfNqTln4mMFrT+yJqdwTII8qDED2Bzez0ktAz3lcTApD+AnePcsoy3xhXKTrvWvr
        eDguiJtA==;
Received: from [177.183.162.244] (helo=[192.168.0.5])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nwoo4-008dUh-LG; Thu, 02 Jun 2022 19:40:25 +0200
Message-ID: <d3dd4f45-1d50-2164-447b-d4f27ac6e133@igalia.com>
Date:   Thu, 2 Jun 2022 14:39:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 0/2] UEFI panic notification mechanism
Content-Language: en-US
To:     ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, anton@enomsg.org, ccross@android.com,
        keescook@chromium.org, matt@codeblueprint.co.uk,
        matthew.garrett@nebula.com, tony.luck@intel.com,
        linux-efi@vger.kernel.org
References: <20220520195028.1347426-1-gpiccoli@igalia.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220520195028.1347426-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard, apologies for annoying!

Just a friendly ping asking if you have any opinions about these patches.

Thanks in advance! Cheers,


Guilherme
