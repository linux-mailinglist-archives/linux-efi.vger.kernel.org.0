Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9E64F7EBA
	for <lists+linux-efi@lfdr.de>; Mon, 11 Nov 2019 20:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfKKTFn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Nov 2019 14:05:43 -0500
Received: from mail-yw1-f50.google.com ([209.85.161.50]:41064 "EHLO
        mail-yw1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbfKKTFk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Nov 2019 14:05:40 -0500
Received: by mail-yw1-f50.google.com with SMTP id j190so5539948ywf.8
        for <linux-efi@vger.kernel.org>; Mon, 11 Nov 2019 11:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=USC+ean2zCjbw40hyUC9AMXI77Zyo0AFapAoVU/VFHk=;
        b=h8reDHaDRHFzOI2Pj+/SEe0SJqf2wUPJq38+PVW7z32fFfQT+QdfY+BHHphDvp6Iw3
         q3n7DCfdYhXrBbgzfnErYxJv0LUK1JG6sNmMDzfq01uud0ZcMHPTHp5qDUtNxefU3qp1
         +vYsYL25Epn2kn9gnzLaNyTxuDFW1z5K1mxMgJkT8X5XImqBionuH5wCw1gXAPn10Ef6
         xNVhru9Oek3+ingwRcuvIa7EDpqt92WsHOO7+FC0U2FwK/xFKW33CcYzLtkj0SmVK/s4
         aGw2PXQ++DPDDfMPWTpMqt6u+9FE5U3XcVpENF8Imwp7YGyVd6/4o7hljiSVL6DyzFrP
         rxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=USC+ean2zCjbw40hyUC9AMXI77Zyo0AFapAoVU/VFHk=;
        b=dnc6o2mAzsAVZwoxQojLUexPT5fc3LQfCuLGERoxCtcIJ99ZjzD+nJ390p2YA/J6XQ
         1kyCC0pRcgxYyRU4y4z/396HyqviDgqgqwCGn2Xt6CBmZfDkXjQ3xYvqoiT16oWrhEzZ
         cu85auC6IJSsfRZks4JrsFFXgDK/nAEjDrN/raMTRdP6m76FtlyUTwOzHHLk/hVXiL/e
         RRuQ2+l1CjOK+ju+761w4NFGIbGlXWKPDrCS5crfW98SObsKLe0bn074Pi9UpL88oFMs
         gULySLBhlAEU9yPiimc3Wv03awMLhjqIkfEfer9YWLYS+e1y/mclxbwbW+8nVQDoKxn7
         fXXQ==
X-Gm-Message-State: APjAAAUsZ1QEIG1IEBMQTVCYQf94qXKdrNhXEGx9BuGOZtaMDWSC1wBA
        7BN7SxWBmXd0lBppihg2FbjqA6Jx
X-Google-Smtp-Source: APXvYqxgSBCFyeu9GkdY/nphptBUEiwjJOpX22LviFNLqcYxWnn3Ukh5eiT5ktvekCUu9NnxOtxtnQ==
X-Received: by 2002:a81:7a05:: with SMTP id v5mr2524511ywc.259.1573499138809;
        Mon, 11 Nov 2019 11:05:38 -0800 (PST)
Received: from ?IPv6:2601:244:4d01:52df:40f2:6b8f:f857:28ef? ([2601:244:4d01:52df:40f2:6b8f:f857:28ef])
        by smtp.gmail.com with ESMTPSA id b63sm4621635ywc.94.2019.11.11.11.05.38
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 11:05:38 -0800 (PST)
To:     linux-efi@vger.kernel.org
From:   Kyle K <kylek389@gmail.com>
Subject: Linux 5.3.8: gsmi: failed to allocate name buffer. BUG: kernel NULL
 pointer dereference
Message-ID: <ac8c3a1d-e44a-4f89-8a58-fb3ef09659d4@gmail.com>
Date:   Mon, 11 Nov 2019 19:07:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205445

Someone please take a look at this. There's is a regression in Linux 
5.3.8 related to google EFI code changes that is causing sideeffects on 
Coreboot enabled laptops resulting in inability to suspend/wakeup and 
WiFi troubles. There's is another person experiencing same issue when 
upgrading to 5.3.8, so this bug is pretty much confirmed.

