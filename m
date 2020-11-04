Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D688A2A719E
	for <lists+linux-efi@lfdr.de>; Thu,  5 Nov 2020 00:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732982AbgKDXZP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Nov 2020 18:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733103AbgKDXYk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Nov 2020 18:24:40 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6AFC0613CF
        for <linux-efi@vger.kernel.org>; Wed,  4 Nov 2020 15:24:40 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j10so376287ybl.19
        for <linux-efi@vger.kernel.org>; Wed, 04 Nov 2020 15:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=djQArc3mN6RTjXnfm4TeJFSrNM6MLG8pt0aHLvmVPeE=;
        b=JGYD3zC/B6na1flL0NEpC//e9oTJ+GagqF9wpqwzhPJ3qgKTK+UPVz0YAyIJciTKyr
         UFZoP7dIPtEqoJh8we3PbbzGAZkRe3ZAQh3baJaOEAxb8BmT1z6Mb61Zbg8lBQnJGSga
         y5pP7p7WK8eSl/20ySFUQB6n3cu4IK7/fB/0E4YtTnkwbt6dBfs0JQAXK01p/dVm6wtt
         WnPEelIQQabnq+vuvCkcwUFw+9meVSj1/QuduEGzUxEvsEOUrrOVv1oYF2BdEXh989SI
         cvxqClzUQiAov8Yt79IfwHQ0vnqmr53wQEMJ9obLrjGyKnRY4P8am2dsskdjUV/Iaima
         bTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=djQArc3mN6RTjXnfm4TeJFSrNM6MLG8pt0aHLvmVPeE=;
        b=m81lMuhH9cURjDRRGw3icXYIAvwFKy+6CtEw2w+Ld0RZsOC1vICVVm/Ll+a3Mc5wwS
         SAfxb/Y7cCniOjdCgjEQ/EUzSiXljp+v7vQL2JrEzEMv/h2mLNaEu7MkZjjRtOuEHlsN
         B3Di7DE+raI6bhOk9IX97fgPXBE4RHE23lJN61b8GaB6a5us83lr6XpMnl/E7CQUSevE
         mpP+7JyrwIV31JP5itgthdw5EczcRaXm9sJlPSxrwMsiFNMgoz9g3QkpswpkuW2gAIz4
         tPPcE4Kbji2+6Wz1cYvjoy2s+Oar8C6AeT5bUNuAifAg6r3oLFt7gbh4yzw8CT9jri2R
         1fvg==
X-Gm-Message-State: AOAM530JhTBD55WNAdw+ajqw9ITGIO9VrA6KWxwj/8RayTsOsUNQvFTJ
        MS+XVGjMgYf0x9PPCq/uhqaueNAQRYft3/A=
X-Google-Smtp-Source: ABdhPJy+LYBmNw8E+/HyzSoPD8y31ef2NPZmNB2LG0ChlatFbQ7ILgAiYxo0NB5Vw6CGtw/VUvkq+9Rtj7of1NI=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:24b:: with SMTP id
 72mr336741ybc.138.1604532279855; Wed, 04 Nov 2020 15:24:39 -0800 (PST)
Date:   Wed,  4 Nov 2020 15:23:53 -0800
In-Reply-To: <20201104232356.4038506-1-saravanak@google.com>
Message-Id: <20201104232356.4038506-17-saravanak@google.com>
Mime-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v1 16/18] efi: Update implementation of add_links() to create
 fwnode links
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

The semantics of add_links() has changed from creating device link
between devices to creating fwnode links between fwnodes. So, update the
implementation of add_links() to match the new semantics.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/firmware/efi/efi-init.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index b148f1459fb3..c0c3d4c3837a 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -316,11 +316,10 @@ static struct device_node *find_pci_overlap_node(void)
  * resource reservation conflict on the memory window that the efifb
  * framebuffer steals from the PCIe host bridge.
  */
-static int efifb_add_links(const struct fwnode_handle *fwnode,
+static int efifb_add_links(struct fwnode_handle *fwnode,
 			   struct device *dev)
 {
 	struct device_node *sup_np;
-	struct device *sup_dev;
 
 	sup_np = find_pci_overlap_node();
 
@@ -331,27 +330,9 @@ static int efifb_add_links(const struct fwnode_handle *fwnode,
 	if (!sup_np)
 		return 0;
 
-	sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
+	fwnode_link_add(fwnode, of_fwnode_handle(sup_np));
 	of_node_put(sup_np);
 
-	/*
-	 * Return -ENODEV if the PCI graphics controller device hasn't been
-	 * registered yet.  This ensures that efifb isn't allowed to probe
-	 * and this function is retried again when new devices are
-	 * registered.
-	 */
-	if (!sup_dev)
-		return -ENODEV;
-
-	/*
-	 * If this fails, retrying this function at a later point won't
-	 * change anything. So, don't return an error after this.
-	 */
-	if (!device_link_add(dev, sup_dev, fw_devlink_get_flags()))
-		dev_warn(dev, "device_link_add() failed\n");
-
-	put_device(sup_dev);
-
 	return 0;
 }
 
-- 
2.29.1.341.ge80a0c044ae-goog

