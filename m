Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5245BE5BC
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 14:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiITM2E (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 08:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiITM2D (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 08:28:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED0C53021
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 05:28:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16033B80C98
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 12:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461B8C433D6;
        Tue, 20 Sep 2022 12:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663676879;
        bh=jpEOe7b88xXqsPjF5/O4qxu0XBjc4SBUVOWyo4qWcxI=;
        h=From:To:Cc:Subject:Date:From;
        b=AVSKAztjOoY2lL/aLbZ9URioO1VmlEXJHCiwZm2fu827+gbq/sKkVI1ptrhlUuNKG
         sWze547QyQdFTZ/vIIM/HMVly6AdreEaAdgB/XI1FuMsWFL8JpYTmbLq4jARVCfmTi
         SyK65CQtT+cyOnFzp9jTMWc/oMRsjjwgKnbfyz6oizUBd6eeIR7f03oaMb+SGBAE0y
         D7FC/hFNRPjfrsvmi10TbNkgR/0jVA66Ub7ws2qBeYV+U3hysWfpeSKvHwywcPBZxa
         rXwvDRgcri1DzhFbeOE25YM6FDvyMSHeTP0JNU0HrdOFaeZCtx6bS7Pi5paHDQsARn
         nbzXZOYZAETlw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "Xu, Min M" <min.m.xu@intel.com>
Subject: [PATCH v2 0/2] efi: measure kernel command line
Date:   Tue, 20 Sep 2022 14:27:44 +0200
Message-Id: <20220920122746.3553306-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082; i=ardb@kernel.org; h=from:subject; bh=jpEOe7b88xXqsPjF5/O4qxu0XBjc4SBUVOWyo4qWcxI=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKbG+0dYXWuC/oUDruXOC6Hs82jLxqSm6e/HBq03c WRru8RuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYymxvgAKCRDDTyI5ktmPJO4SC/ 9OnOTWxsiT0DkP7ieKqODVBrU/KAiY6ACSz/3++f+bBVn6ayzqMo6mTRD/DcTlKylJD58og/fyDJUV VVQCLqWqRmNPGqzJmsPnFWPwS4Q+048EDGQs0iIWcof8Qu7x90H+wMmQKBtNjh72d7x6d+sdUuVxVd g0DEgFtF3vgw0zmaYJhFG2acgdF0aYm+6Ghbw1vgrkROTBD6fbWzZRSqp3uVyy7b6E6B2SUv7SAH9n zqku4OcaUlt0Ge95YrvSs3dRVJpVs0vYwI8pCVJfEpGb28SQtEfDuWj0zXIJ8d/jcLy9Ll+SveBR1E mVoNp67loW2F667bLSahY2FshRK+ISF3o1JPGpq1P47NYoPcEypkh7me/zoowCYwyPpaWrdiMdR3xI 6iuEaI7KyhunXZLCtdaHTilhkiX0L7FhX7g8MnJM05Knc8p9H/1cTP4VjJs/lgNeTrr2hW9PxbPScE 7P1NaRaDlSVP0/pu9X5hT6TBo/8njNk4f/ckBlE8KEHpI=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Measuring the kernel command line (or more generically, image load
options in EFI parlance) is not covered by the TCG spec, which only
reasons about images started as boot options.

Let's work around this oversight by measuring the kernel command line
from the EFI stub itself. Since load options is essentially just a
sequence of bytes, which happens to be interpreted as UTF-16 and
subsequently converted into ASCII before being used as the kernel
command line, let's just measure the whole thing and not the resulting
ASCII string.

Cc: Peter Jones <pjones@redhat.com>
Cc: Matthew Garrett <mjg59@google.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: "Xu, Min M" <min.m.xu@intel.com>

Ilias Apalodimas (2):
  efi/libstub: refactor the initrd measuring functions
  efi/libstub: measure EFI LoadOptions

 drivers/firmware/efi/libstub/efi-stub-helper.c | 130 +++++++++++++-------
 drivers/firmware/efi/libstub/efistub.h         |   1 +
 2 files changed, 88 insertions(+), 43 deletions(-)

-- 
2.35.1

