Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF7156BA74
	for <lists+linux-efi@lfdr.de>; Fri,  8 Jul 2022 15:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbiGHNOb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Jul 2022 09:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbiGHNO2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 8 Jul 2022 09:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E94AAD98
        for <linux-efi@vger.kernel.org>; Fri,  8 Jul 2022 06:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657286065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xahRR/MGCN4opUKZtfERLy3MATM50vexXH0Q0OxZ6Kk=;
        b=QQE/vPHMRwFSKvenSXNGt7xWAKTQSTQ6jCZGArLhSzzkk27ls/CFD61vKCG3j1Pn1ezl+R
        Zm2r7x8HmMqwhnbvem73ppYJcAEIlU6YDrWumNQzZb3MH0EU5D/z3q55FNTZsPYH1qniYK
        VB4K0QMePo3+JGlhgoH9ad3IS8rU/cc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-vFZrUz05PrOtVJI0C0VS3A-1; Fri, 08 Jul 2022 09:14:15 -0400
X-MC-Unique: vFZrUz05PrOtVJI0C0VS3A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64F2219705AB;
        Fri,  8 Jul 2022 13:14:14 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B43461121314;
        Fri,  8 Jul 2022 13:14:12 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        x86@kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH 0/2] Fix 2 5.19 power-off regressions caused by sys-off-handler work
Date:   Fri,  8 Jul 2022 15:14:10 +0200
Message-Id: <20220708131412.81078-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi All,

I noticed that my Lenovo Yoga Tablet 2 1050L was hanging on power-off again
with 5.19, even though I had implemented a workaround for this in 5.17 .

I quickly realized that this was caused by the recent sys-off-handler work
and fixed this by switching the workaround over to register_sys_off_handler
with a priority of SYS_OFF_PRIO_FIRMWARE + 1, so that the workaround runs
before acpi_power_off() get a chance to run.

This made me realize that the efi_power_off handler which sometimes is
used in preference of acpi_power_off had the same problem, so the second
patch in this series fixes that.

I plan to include patch 1/2 in a fixes pull-req to Linus soon. Ard,
if I can get your Ack for 2/2 then I can include this in the pull-req
if you want; or you can send this to Linus yourself.

Regards,

Hans


Hans de Goede (2):
  platform/x86: x86-android-tablets: Fix Lenovo Yoga Tablet 2 830/1050
    poweroff again
  efi: Fix efi_power_off() not being run before acpi_power_off() when
    necessary

 drivers/firmware/efi/reboot.c              | 21 +++++++++++----------
 drivers/platform/x86/x86-android-tablets.c | 17 +++++++++++++----
 2 files changed, 24 insertions(+), 14 deletions(-)

-- 
2.36.0

