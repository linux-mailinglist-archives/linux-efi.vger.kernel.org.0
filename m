Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43BBD38EDE
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2019 17:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfFGPWs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jun 2019 11:22:48 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:41384 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbfFGPWs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jun 2019 11:22:48 -0400
Received: by mail-qk1-f177.google.com with SMTP id c11so1470232qkk.8
        for <linux-efi@vger.kernel.org>; Fri, 07 Jun 2019 08:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=EXSmSWjcDB1szNpUZ4RnHlO+2EIGCfLRdk7Vv90DHik=;
        b=egnZVNmpT+xaStlzfGJh/0+mgbm9Y1D3frhr8us4SZ0cc+8P1SqFWwbZeJkeLGvBYg
         vmcQo+AQrNm94yjlLva8y/EE5ss3LNdbcCepnPnb0EMpW7lZ/jwdQE2CkTgFo6R1Qrpl
         itLjlfyRcl+/7ucoTB3iMRia0IuNop9r5ZoAY3ydtCpxEjME/kxXMUE+kg4QQxYBytVr
         AvdkvU9/fcAQrIjmbhID3rtrRQE8/wLVCjd9Zo1lhMWjVkAyAEkp3MhN4mv+yEfp8wdI
         MyrDrbYIiOYnkjZKhNkZCAcKTWYM86rPHzCFB9OU6EApBzC7mspDMr5dbZejDKGF5oT0
         8hLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=EXSmSWjcDB1szNpUZ4RnHlO+2EIGCfLRdk7Vv90DHik=;
        b=d5jlxdHDncdWQC+cZmb3VHndqefTcbqbJ3SDdJ2Uo7JKSK7jojIIsUByPK3up2M90w
         QeEYwgUtMxNjKiK+mQknScmfTt0iGN03NWBtbJJbev4+kdEFVZbk7Yev+M6n4FDdaOEd
         63n6yrk+g+J1U/0Lr77qvietpv1GQj/y6eQUQ1vB0YXEF4uTDQQQGQe6v0tCsPpwQjYu
         0PivuwXckdVdo14o93uascGJArqnvU9lITKuAZTZhuB/+0In48IH1XpdaPhNlNNgI1v2
         +H2dU8Mgk7TF5FkkLmp9j5WWjjIsK+blxJKgDPbs5IPyDoaIQuDGyi2u+K8GFRUeObEW
         33TQ==
X-Gm-Message-State: APjAAAXO2leYaODcRXPvMMUAQLZH+AixoZNVJzcQFuz6OVY0USHEODxv
        u6SSgugs9If2vS++/L0Ww2dlaZba3hQ=
X-Google-Smtp-Source: APXvYqy2bl40AjAKSQ91cJSFv3ieqdq17wcLtP1KGmw5Lg/DXfJAm/maZoQXjHWA5ZhBJnnO2CAnjg==
X-Received: by 2002:a37:640f:: with SMTP id y15mr43201126qkb.79.1559920967395;
        Fri, 07 Jun 2019 08:22:47 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k54sm1404799qtk.54.2019.06.07.08.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 08:22:46 -0700 (PDT)
Message-ID: <1559920965.6132.56.camel@lca.pw>
Subject: "arm64: Silence gcc warnings about arch ABI drift" breaks clang
From:   Qian Cai <cai@lca.pw>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org
Date:   Fri, 07 Jun 2019 11:22:45 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The linux-next commit "arm64: Silence gcc warnings about arch ABI drift" [1]
breaks clang build where it screams that unknown option "-Wno-psabi" and
generates errors below,

[1] https://lore.kernel.org/linux-arm-kernel/1559817223-32585-1-git-send-email-D
ave.Martin@arm.com/

./drivers/firmware/efi/libstub/arm-stub.stub.o: In function
`install_memreserve_table':
./linux/drivers/firmware/efi/libstub/arm-stub.c:73: undefined reference to
`__efistub___stack_chk_guard'
./linux/drivers/firmware/efi/libstub/arm-stub.c:73: undefined reference to
`__efistub___stack_chk_guard'
./linux/drivers/firmware/efi/libstub/arm-stub.c:93: undefined reference to
`__efistub___stack_chk_guard'
./linux/drivers/firmware/efi/libstub/arm-stub.c:93: undefined reference to
`__efistub___stack_chk_guard'
./linux/drivers/firmware/efi/libstub/arm-stub.c:94: undefined reference to
`__efistub___stack_chk_fail
