Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D91627956
	for <lists+linux-efi@lfdr.de>; Mon, 14 Nov 2022 10:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbiKNJqM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Nov 2022 04:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbiKNJqK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Nov 2022 04:46:10 -0500
X-Greylist: delayed 507 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Nov 2022 01:46:09 PST
Received: from relay.mgdcloud.pe (relay.mgdcloud.pe [201.234.116.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1361B9F3
        for <linux-efi@vger.kernel.org>; Mon, 14 Nov 2022 01:46:09 -0800 (PST)
Received: from relay.mgdcloud.pe (localhost.localdomain [127.0.0.1])
        by relay.mgdcloud.pe (Proxmox) with ESMTP id 0F2AD2297FC;
        Mon, 14 Nov 2022 04:36:31 -0500 (-05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cgracephoto.com;
         h=cc:content-description:content-transfer-encoding:content-type
        :content-type:date:from:from:message-id:mime-version:reply-to
        :reply-to:subject:subject:to:to; s=Relay; bh=POmmLhbs6/14Mhmcbsw
        HpX0H+MIlo+W0e6cG8XDkBG8=; b=OmWIXu8TozzaAbTB1i3JnrHz6DM0Q6mJ1pH
        c4zToYBhRrBnKr3VDNCmj+0xy7xPwyH33p/xjCBypZyeZjSeP9uiFxNjVY0Fh8Bp
        D5Ge3gd5NC8yvXbobN/ShIEPiq/rsdwqwi+zoCvMPO0eepTbrYlqpo5rqlV7EunR
        QisZUjxy3biwSbz+QVCRX2rbUy8iDv5B/aPXTCC7jV+EWOuceglOudK40/HfQJOY
        7D99HSfc917KeEyDCyCb2/iYvdYoPrpFxvMUqwLBj+LY10vO1+ej0EEYV+9F26eW
        Rk/3B1GN/4ZZY/C0MZNnVPjNnSTuYNNpK54xup4dlI+0ejeoqUQ==
Received: from portal.mgd.pe (portal.mgd.pe [107.1.2.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by relay.mgdcloud.pe (Proxmox) with ESMTPS id EADC7229446;
        Mon, 14 Nov 2022 04:36:30 -0500 (-05)
Received: from localhost (localhost [127.0.0.1])
        by portal.mgd.pe (Postfix) with ESMTP id C3F0420187D84;
        Mon, 14 Nov 2022 04:36:30 -0500 (-05)
Received: from portal.mgd.pe ([127.0.0.1])
        by localhost (portal.mgd.pe [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VC-lhatH9T_q; Mon, 14 Nov 2022 04:36:30 -0500 (-05)
Received: from localhost (localhost [127.0.0.1])
        by portal.mgd.pe (Postfix) with ESMTP id 6591220187D82;
        Mon, 14 Nov 2022 04:36:30 -0500 (-05)
X-Virus-Scanned: amavisd-new at mgd.pe
Received: from portal.mgd.pe ([127.0.0.1])
        by localhost (portal.mgd.pe [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id N8-Ld5O2e6Wn; Mon, 14 Nov 2022 04:36:30 -0500 (-05)
Received: from [103.125.190.179] (unknown [103.125.190.179])
        by portal.mgd.pe (Postfix) with ESMTPSA id DE20520187D83;
        Mon, 14 Nov 2022 04:36:23 -0500 (-05)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Strategic plan
To:     Recipients <cindy@cgracephoto.com>
From:   "Mr.IgorS. Lvovich" <cindy@cgracephoto.com>
Date:   Mon, 14 Nov 2022 01:36:22 -0800
Reply-To: richad.tang@yahoo.com.hk
Message-Id: <20221114093623.DE20520187D83@portal.mgd.pe>
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_REPLYTO,HK_NAME_MR_MRS,RCVD_IN_SBL,
        SPF_FAIL,SPF_HELO_PASS,TO_EQ_FM_DOM_SPF_FAIL,TO_EQ_FM_SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello
I will like to use the liberty of this medium to inform you as a consultant=
,that my principal is interested in investing his bond/funds as a silent bu=
siness partner in your company.Taking into proper
consideration the Return on Investment(ROI) based on a ten (10) year strate=
gic plan.
I shall give you details when you reply.

Regards,

