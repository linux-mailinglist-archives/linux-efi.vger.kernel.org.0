Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88D3738EFA
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2019 17:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbfFGP0P (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jun 2019 11:26:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34201 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729875AbfFGP0P (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jun 2019 11:26:15 -0400
Received: by mail-qt1-f194.google.com with SMTP id m29so2729850qtu.1
        for <linux-efi@vger.kernel.org>; Fri, 07 Jun 2019 08:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jPHq4OxP074Oynm5k40N1pEDJSRTgbxUT/ySAPSAN/g=;
        b=mgDqnIZBA6Gyk3/0NfMutNIfj1G7UuL9197sMB2o2zLU6maboq4TpP6AkBdLmlwPhJ
         20J0LzfYGqZASKtqrboNa9WLrIpQf/uHbUz0DkQ46tWXymwGRAQ0ZMNOFEC6xc5UVCDC
         BPK17IQDb02K2wwmyhdXlmsQ4sXpngtWcr8UZwHLFjO/FH0tICMK86B9c3Z48gFCeJTj
         SOWpKsFFSJnngDw1Je440yV/vA8RwkZHNlhOzcSn7gAA4ZCZjrD1p7whYqppnIMn1bhq
         ZayNNP6pIqAjwMQxZ8KkV9Kb+1JhyNuKUimtV9S53FBMTg4jF1+nJ8SZYRn1SB/JSwf0
         A/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jPHq4OxP074Oynm5k40N1pEDJSRTgbxUT/ySAPSAN/g=;
        b=YFihxCPephQ7bFijqfct4K6pwePEQii+cxUVvgX4q3Axi09FU+V+DS1IsDRG5HehlZ
         Y4PRgByv4DiT+UgYWQZ8ETm+zxw5mV6eqTw4QINpNfGB5qr6NhuSm0mClfq1AkizkhNV
         EBhuSKTI8B9ZUtDedw4Ola7vjm31LJLIs3W18y6+AfwSt958nbt6Mxz1Mi5S2IUlOLZz
         U8GbilC19mnq1rCetrH+Rq7QBcekBAm2KQI9UaMJNkoYNp7UtLdQ3VBjb/FmATOUQv9X
         umfldSI8DA/8hyQNcel+2h8kfR1LldtcCSH5ky3JOncF3UKc6Rk+ge8OTGaGIQWzHiR3
         OfwQ==
X-Gm-Message-State: APjAAAXJNp6XmvrrZaxnEX6BrpJtIvbwfE1mZj4mLRD7djxYMnpIi0EX
        PRZOIBWuIKv8t+Gx5kEwyqTmKQ==
X-Google-Smtp-Source: APXvYqwEftljuOnjBWqRLIWBJyHK8pMOwSajpYXoDYal/be+IwViGPGypV7PqpotWIkVRwrSZXx3fw==
X-Received: by 2002:ac8:2cba:: with SMTP id 55mr29893254qtw.260.1559921173712;
        Fri, 07 Jun 2019 08:26:13 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f34sm1359441qta.19.2019.06.07.08.26.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 08:26:13 -0700 (PDT)
Message-ID: <1559921171.6132.57.camel@lca.pw>
Subject: Re: "arm64: Silence gcc warnings about arch ABI drift" breaks clang
From:   Qian Cai <cai@lca.pw>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org
Date:   Fri, 07 Jun 2019 11:26:11 -0400
In-Reply-To: <20190607152517.GC19862@fuggles.cambridge.arm.com>
References: <1559920965.6132.56.camel@lca.pw>
         <20190607152517.GC19862@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2019-06-07 at 16:25 +0100, Will Deacon wrote:
> On Fri, Jun 07, 2019 at 11:22:45AM -0400, Qian Cai wrote:
> > The linux-next commit "arm64: Silence gcc warnings about arch ABI drift" [1]
> > breaks clang build where it screams that unknown option "-Wno-psabi" and
> > generates errors below,
> 
> So that can be easily fixed with cc-option...
> 
> > [1] https://lore.kernel.org/linux-arm-kernel/1559817223-32585-1-git-send-ema
> > il-D
> > ave.Martin@arm.com/
> > 
> > ./drivers/firmware/efi/libstub/arm-stub.stub.o: In function
> > `install_memreserve_table':
> > ./linux/drivers/firmware/efi/libstub/arm-stub.c:73: undefined reference to
> > `__efistub___stack_chk_guard'
> > ./linux/drivers/firmware/efi/libstub/arm-stub.c:73: undefined reference to
> > `__efistub___stack_chk_guard'
> > ./linux/drivers/firmware/efi/libstub/arm-stub.c:93: undefined reference to
> > `__efistub___stack_chk_guard'
> > ./linux/drivers/firmware/efi/libstub/arm-stub.c:93: undefined reference to
> > `__efistub___stack_chk_guard'
> > ./linux/drivers/firmware/efi/libstub/arm-stub.c:94: undefined reference to
> > `__efistub___stack_chk_fail
> 
> ... but this looks unrelated. Are you saying you don't see these errors if
> you revert Dave's patch?

Yes.
