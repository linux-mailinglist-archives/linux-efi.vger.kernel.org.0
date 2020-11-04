Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A682A7176
	for <lists+linux-efi@lfdr.de>; Thu,  5 Nov 2020 00:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732813AbgKDXYP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Nov 2020 18:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732803AbgKDXYK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Nov 2020 18:24:10 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738D9C0613D3
        for <linux-efi@vger.kernel.org>; Wed,  4 Nov 2020 15:24:10 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id x10so9131773qvo.22
        for <linux-efi@vger.kernel.org>; Wed, 04 Nov 2020 15:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mDVvKrGHCP/3KBqD6Y+81Awc8s23VoJcXWEM4lmGqQk=;
        b=UrcXOwPS8nM7/ikskpgkXlxdwbC7fRg65vxlDw6UBrphzbOZujaNWx+XnNzrdvfUG/
         /zmaPWK7O35YUG+60QYL1UALaOrJ6CfR6nAGsV2hplG8Yf26liCR0ccZzdSHdbBupXXJ
         rY2CqHrp20pwo/CTtzIxcuqLuKGrA14ZoXu6KCts9HWKDuYEOTfNM63I0dPMDajm9Wzp
         jWtQomAP9PBmL8GgNtu0xnEm8BEEHQKYoQ6NMZMN7wSfQLGLJ+qokqu6ep05laZoVOK9
         pgZxS63+uVe2nNyTrMSxZTqlRYb3DosJhQyFFGylNr7KUnAU0tLAXJQV4z2s8Hl7PYzA
         Pi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mDVvKrGHCP/3KBqD6Y+81Awc8s23VoJcXWEM4lmGqQk=;
        b=FDI0gC17iWkqNRteYjEkQAtazidZZOwR9Y9GCpUB0YalSMkoVA3AZ57LugixAox2dK
         kb5QTVINh6/sc188035+XfuZMY7ZMpHOgrjZXJCUNhOWWy58HAgAxSjaKrMjKJug1ios
         BbEY0BsAZWc5WOlp/3q2rIK4NgDP3Zp31q+qaB7W13yFMmtrfYY8cPX7Cj9qSDIoQUSz
         aYvJX/MK8PjWpPsIvgn1nsfkZPV8lXVMHdjo1nUlcmhdDxrob4LFx2vtPL4DWmXwtMjT
         J/5Km0OEsPwUYWjnM/6Z2dXMBAOluUD4ictx5gT/iFAXyJWbzTQs3uzeIfzFVS2L28G6
         9Mdw==
X-Gm-Message-State: AOAM533eiaJh3G9QSrISlPNB9JA73kz6QFv/5HHkZJVwQ2P5MHxs3INN
        KIbkRQBQtpmDTwuND46YF+kePeQe48jfQ48=
X-Google-Smtp-Source: ABdhPJznoHrAzCZtFLgjYhiJnzq1jZvYLPBro0eYGGwHHgz+egObOJnpHGOf9HuWhTEgl/sUfC0vy14swG3g6NM=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:ad4:4205:: with SMTP id
 k5mr310786qvp.10.1604532249490; Wed, 04 Nov 2020 15:24:09 -0800 (PST)
Date:   Wed,  4 Nov 2020 15:23:41 -0800
In-Reply-To: <20201104232356.4038506-1-saravanak@google.com>
Message-Id: <20201104232356.4038506-5-saravanak@google.com>
Mime-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v1 04/18] Revert "driver core: Remove check in driver_deferred_probe_force_trigger()"
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

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/dd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 008724f8edf1..ec67b5ffa06d 100644
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
2.29.1.341.ge80a0c044ae-goog

