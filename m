Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F12E2BBBE5
	for <lists+linux-efi@lfdr.de>; Sat, 21 Nov 2020 03:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbgKUCC5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Nov 2020 21:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbgKUCCz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Nov 2020 21:02:55 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C38AC061A4A
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:02:55 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id t22so4271018qtq.2
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=FtaTOwMgGmGPcDccT1+KEgyZhtmrcZTBLb1q5hL1SLA=;
        b=Ac0jmK/3hoJ6QZAP/9XaK7BeTu9I5N8+kn3tNCfamljj/K0nywlZnbtmuU5NgLmMcu
         sUbtiUXyDbCTAQ2Xshaa2HGhNPPPEjIf0qJOVp+G0J7btHs+9unrGI12/iVWojAR+abb
         Lt8C89A7AgZjVIOZW45yMtwbE+jPUM7BzG6ECmw4CqyE9oyqk31FMGgAs90dVMfZ3rU9
         iib59EfhMOYMWLnua4tzDVZHtPXdNKPRSpQ/Lq+MERZrWXuMQy9Xb2L4jFeOsMPyhhZQ
         COc04F9D7Ag4TzKZtX88UV/eGX0WxitPFezcjk0Y/uhzE8yTb9Zq8iQPkxk+qVN4SyCt
         r81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FtaTOwMgGmGPcDccT1+KEgyZhtmrcZTBLb1q5hL1SLA=;
        b=jfP4nyGs2S85+nTsKys1msr5QQkeFbNmorFJSE2FP7So/z0IGTRSu571C9o+cT5X/t
         IWIht53AyKipg2zT5yzA+BYBTNTSR7wOG9hCKb7Q0IPDrcBDTCJzWqLGS2wW/5iDQ2Fw
         PuOUY69P7aOoVrnx7uNZ1y09el77hmUWTEOkrEQo8Lw33jXKvPfsGQAj7fH3NN7vEvsS
         NG2Ru7BjaW825uIZHF5p0dH6pDjFB/3wYyoMiSWUADkZ6GCaKQL+cb+YR2i++Bfasb0d
         8cEmmwRBWxtMFPL0CCrZe+bWkgJuqZ+qT3UFj03GjvE79XDJWFKJHEPRVpB0DcGRmaLg
         V08Q==
X-Gm-Message-State: AOAM533Khh1R6fVxc9BimaNU97dq6/yw9iFOnXdCL9T2at2ENf7BdOT+
        7om4eC+oHFunroif+A+U7xrO7hg5s6dM8x8=
X-Google-Smtp-Source: ABdhPJw3F3Z+sPzXK3HTFpQkXFaE42tDe9RSR4zAB0UdCc8342U28KWTe468JI4C2ciybBxluYLmcyih0INiCJg=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:ad4:5beb:: with SMTP id
 k11mr19789884qvc.20.1605924174528; Fri, 20 Nov 2020 18:02:54 -0800 (PST)
Date:   Fri, 20 Nov 2020 18:02:19 -0800
In-Reply-To: <20201121020232.908850-1-saravanak@google.com>
Message-Id: <20201121020232.908850-5-saravanak@google.com>
Mime-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 04/17] Revert "driver core: Remove check in driver_deferred_probe_force_trigger()"
From:   Saravana Kannan <saravanak@google.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        kernel-team@android.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This reverts commit fefcfc968723caf93318613a08e1f3ad07a6154f.

The reverted commit is fixing commit 716a7a259690 ("driver core:
fw_devlink: Add support for batching fwnode parsing"). Since the
original commit will be reverted, the fix can be reverted too.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/dd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 001caa0b447c..b4be35fa7fda 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -172,6 +172,9 @@ static void driver_deferred_probe_trigger(void)
 
 void driver_deferred_probe_force_trigger(void)
 {
+	if (!driver_deferred_probe_enable)
+		return;
+
 	/*
 	 * A successful probe means that all the devices in the pending list
 	 * should be triggered to be reprobed.  Move all the deferred devices
-- 
2.29.2.454.gaff20da3a2-goog

