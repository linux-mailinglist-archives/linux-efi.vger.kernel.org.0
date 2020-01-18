Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECFB7141720
	for <lists+linux-efi@lfdr.de>; Sat, 18 Jan 2020 12:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgARLEf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 18 Jan 2020 06:04:35 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:40454 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgARLEe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 18 Jan 2020 06:04:34 -0500
Received: by mail-qt1-f175.google.com with SMTP id v25so23884135qto.7
        for <linux-efi@vger.kernel.org>; Sat, 18 Jan 2020 03:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=E4iQ7ZDNrYmzMAHeHyv3uP9yYvMQ0RsRxXZm7yOz4Cw=;
        b=d6JswzAOQih42l4rSMXXRRxslli+9tAZ/CG+plabBLqdTSTWpFBbQizjSQQe4noFz1
         tLH3kXqsk7JXLwVYkgIbcAYkzZPLvo+3GzHkdFWRxbxs4SHSXPFWRYV8PN+v5U/QF862
         +4z2SbeMzP+bMGu0r5e9ESL6Opxfz9zM1DdG4/fLypExnvDh4NH+yrulsdeSXTDRJMdm
         7l7S2Aed8YKQOYf/2p8Ie1XePlMIlAeUk4AFuCL8dFkqncje3hgSExF5CBpJ8nNtRxzN
         WU6m8X59fZF6KzQm5Qo2mgVv3ZuPzovylKxL+j9aL8qHGcePTraVIwLOJfUSYVa4VUdR
         5iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=E4iQ7ZDNrYmzMAHeHyv3uP9yYvMQ0RsRxXZm7yOz4Cw=;
        b=UiMpK20kmmOrXT1Oe4dXDKrWzEYLvsB9NaywPU298LH5LHx6VEnbb4oM/fagv6MrF6
         NPQ4DluEaqHOOXJzAUI3UgBvXXB2PKL1eBfDhYWIk2jVIyAWNZmJudCxDgFp8ex8QVNl
         /NkCBbGiuKdEzKWPxNvISOycvodglGulUX1OtKWsLBCXHhdARjAtWivC/08bMYjp4NF9
         pvbFVu1V+5NaLmXemZ4K4rqPgN2V4fEW8tqjcAqiPdtLZxpAtspPeIQl9octYVCQF2pV
         Q1tVy8aTRq6pITiKGd9A2tOBuFcht7ZG6Q8WJat7y1qf2wSSIDxbFxBi/mMHUZug9g5Y
         zioA==
X-Gm-Message-State: APjAAAV2hAj8QPctVhIZBQw3Tn2WO2gl6NS4mkZKatjY4LTkBMJ91HAD
        5FPKwjDKMbFfJMMVi1637gAThw==
X-Google-Smtp-Source: APXvYqy0OAWkYxzJHelL7Pu/x/AtY+S1tuMmr4j+WEKJuL9ETD+TUIV95vcmX0JuBSca4Fp5eXLxSQ==
X-Received: by 2002:ac8:7a70:: with SMTP id w16mr11517454qtt.154.1579345471965;
        Sat, 18 Jan 2020 03:04:31 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s1sm12892978qkm.84.2020.01.18.03.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2020 03:04:31 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] x86/efi_64: fix a user-memory-access in runtime
Date:   Sat, 18 Jan 2020 06:04:30 -0500
Message-Id: <934E6F23-96FE-4C59-9387-9ABA2959DBBB@lca.pw>
References: <CAKv+Gu8WBSsG2e8bVpARcwNBrGtMLzUA+bbikHymrZsNQE6wvw@mail.gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CAKv+Gu8WBSsG2e8bVpARcwNBrGtMLzUA+bbikHymrZsNQE6wvw@mail.gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> On Jan 18, 2020, at 3:00 AM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wr=
ote:
>=20
> Can't we just use READ_ONCE_NOCHECK() instead?

My understanding is that KASAN actually want to make sure there is a no dere=
ference of user memory because it has security implications. Does that make n=
o sense here?=
