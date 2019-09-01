Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10389A4BC9
	for <lists+linux-efi@lfdr.de>; Sun,  1 Sep 2019 22:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfIAUfk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Sep 2019 16:35:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfIAUfk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 1 Sep 2019 16:35:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 70E7D4ACA5;
        Sun,  1 Sep 2019 20:35:39 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 954FD608C1;
        Sun,  1 Sep 2019 20:35:34 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Atul Gupta <atul.gupta@chelsio.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/9] crypto: sha256 - Merge crypto/sha256.h into crypto/sha.h
Date:   Sun,  1 Sep 2019 22:35:23 +0200
Message-Id: <20190901203532.2615-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 01 Sep 2019 20:35:40 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi All,

As promised here is a follow-up series to my earlier sha256 series.

Note I have only compiled and tested this series on x86_64 !! 

All changes to architecture specific code on other archs have not even
been tested to compile! With that said most of these changes were done
using my editors search - replace function so things should be fine...
(and FWIW I did do a Kconfig hack to compile test the ccree change).

The first patch in this series rename various file local functions /
arrays to avoid conflicts with the new include/crypto/sha256.h, followed
by a patch merging include/crypto/sha256.h into include/crypto/sha.h.

The last patch makes use of this merging to remove a bit more code
duplication, making sha256_generic use sha256_init and sha224_init from
lib/crypto/sha256.c. An added advantage of this, is that this gives these
2 functions coverage by the crypto selftests.

Regards,

Hans

