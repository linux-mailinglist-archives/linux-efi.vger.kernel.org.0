Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5C0D5A510
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jun 2019 21:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfF1TWE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jun 2019 15:22:04 -0400
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:48782 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726497AbfF1TWD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Jun 2019 15:22:03 -0400
Received: from [4.30.142.84] (helo=[127.0.1.1])
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1hgvoq-000Sw7-RS; Fri, 28 Jun 2019 14:41:57 -0400
Subject: [4.19.y PATCH 0/3] Backported fixes for 4.19 stable tree
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-efi@vger.kernel.org,
        Rob Bradford <robert.bradford@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gen Zhang <blackgod016574@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, akaher@vmware.com,
        srinidhir@vmware.com, bvikas@vmware.com, amakhalov@vmware.com,
        srivatsab@vmware.com, srivatsa@csail.mit.edu
Date:   Fri, 28 Jun 2019 11:41:54 -0700
Message-ID: <156174726746.34985.1890238158382638220.stgit@srivatsa-ubuntu>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Greg,

This patchset includes a few backported fixes for the 4.19 stable tree.
I would appreciate if you could kindly consider including them in the
next release.

Thank you!

Regards,
Srivatsa

---

Gen Zhang (3):
      efi/x86/Add missing error handling to old_memmap 1:1 mapping code
      ip_sockglue: Fix missing-check bug in ip_ra_control()
      ipv6_sockglue: Fix a missing-check bug in ip6_ra_control()


 arch/x86/platform/efi/efi.c    |    2 ++
 arch/x86/platform/efi/efi_64.c |    9 ++++++---
 net/ipv4/ip_sockglue.c         |    2 ++
 net/ipv6/ipv6_sockglue.c       |    2 ++
 4 files changed, 12 insertions(+), 3 deletions(-)
