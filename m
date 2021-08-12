Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3143EA8C8
	for <lists+linux-efi@lfdr.de>; Thu, 12 Aug 2021 18:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbhHLQvw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Aug 2021 12:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbhHLQvw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Aug 2021 12:51:52 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC05C0617A8
        for <linux-efi@vger.kernel.org>; Thu, 12 Aug 2021 09:51:26 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id c23-20020a0568301af7b029050cd611fb72so8525547otd.3
        for <linux-efi@vger.kernel.org>; Thu, 12 Aug 2021 09:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ny72dvyv02gs52BODIXbqFAvUcs0ppK7k7vDL5+fmKc=;
        b=lGNAjICNx3vvf1yMVz0aI7CQek+tBGtccOO5YclAlos8J8uO2FuaOnGuBKQnorAHaM
         Z19xWfK6P8799ph/A4dQ/1oW0106jB/+t7Vq6XAD8sB7LJ+fj3SfBmKcuPrFvpyBTSUo
         Nqsjf3+7Y9zK+gv4drQuEtiF187GIPNNYKp159ix//sRalbYXuV3IXJImDWQCD5CO8Cu
         q/Ic5DjFctOOkRxYaQ6JmxfxUiG24ILQJ/DuI72ipRbbkapa0s2JE6MouOHtE4G6XgJu
         CGZ81hgsaq7ljm30bG7/NTpV5l9SqjNuyhXW9QVE5stkLv+AJ589w/oT9q+W0yb1jnwW
         Qadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ny72dvyv02gs52BODIXbqFAvUcs0ppK7k7vDL5+fmKc=;
        b=tCPvK0OhR85KMHg3tklt1fCf8oAJEAFvXQKuvg9C6pLNrNhhStyqkpEyQ0J3Bd+ozA
         MkV9bb3wZcVubhmYKa6w+NsvmgsCKQW03jhANmYx+39/oTRGdUN/B98kW5grrgT5yikJ
         D6uu1ileSHuWOkTgU6iyOdZHbL8Oxu53aqc+/CJSj4lOQLktl403wbbNpuR50tJjQ5hc
         lpxzn6MVsUVLmdosw3NbX4EEPTLBx35EPjxtdqlIGirHq38cD+D02tiTtCJEKB7eCpv8
         /iRdp+iawcloJFioRFhmM41gAwdD8ce1ymQxyOYtxwD61VBsPv9+/R5Vjn0eO7JRZPp5
         76FQ==
X-Gm-Message-State: AOAM531bWFib7wyD09hGxeaTt6UYyIj0Um/pL1oVmuHGr6uSVhYBmi5p
        z/7TL3iZjQTuqzOf5pD3tUwMxA==
X-Google-Smtp-Source: ABdhPJzLc/kCLGijT6QbBhtFUlVP/yIuX/FFPTJY0ez8pAiOiuUy+sOQkVIfCU1WEJ3z6VKbgyW8eg==
X-Received: by 2002:a9d:175:: with SMTP id 108mr4326252otu.366.1628787086179;
        Thu, 12 Aug 2021 09:51:26 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y33sm709603ota.66.2021.08.12.09.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 09:51:25 -0700 (PDT)
Subject: Re: pass a gendisk instead of block_device in the partitioning code
To:     Christoph Hellwig <hch@lst.de>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
References: <20210810154512.1809898-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9b8b6257-7bb6-9167-483e-153ab082d80f@kernel.dk>
Date:   Thu, 12 Aug 2021 10:51:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210810154512.1809898-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/10/21 9:45 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series passes the gendisk instead of the block_device when operating
> on the whole device in the partition code.

Applied, thanks.

-- 
Jens Axboe

