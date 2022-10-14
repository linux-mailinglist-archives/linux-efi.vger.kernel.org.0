Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134FE5FEC95
	for <lists+linux-efi@lfdr.de>; Fri, 14 Oct 2022 12:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJNKbx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Oct 2022 06:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJNKbw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 14 Oct 2022 06:31:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED20252BF
        for <linux-efi@vger.kernel.org>; Fri, 14 Oct 2022 03:31:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61188B82295
        for <linux-efi@vger.kernel.org>; Fri, 14 Oct 2022 10:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297E4C433D6;
        Fri, 14 Oct 2022 10:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665743509;
        bh=NyF2H5u6SSHt3uzfrY8Ee/4XotULnbGHqGD385CL9ws=;
        h=From:To:Cc:Subject:Date:From;
        b=nMUXlf5v8tq1X4nyVOD/NReXIfZN8nC+2ih2MMhHmpj6PAql8UabZnaVdjzzvr6SR
         jq1i7tD897x7HYQ2hzqmmQxu79MUgcGhWRDxKbrzrIHt7TE5F2+oKKKo4Z22qObCKG
         aLUweBvTexzhwwsOSrtnC/+xdqcwk4BBO2tXEvmOqH6vOxeBJ2yeuWRAdKSebrREct
         SAbjkCzHT1zZJhKXHbHguRfFmROYp7ODQIrcyzunF27Hi2bN5wU0c4ek4OeqFOBk/e
         pIVb8cWWVpQWgtSc9RWTGXYqzeEHwYV7mHehyYD9ULjqyaQzdh3q3Pot9u00djPy82
         VyMVwRQCvh89w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH] efi: ssdt: Don't free memory if ACPI table was loaded successfully
Date:   Fri, 14 Oct 2022 12:31:34 +0200
Message-Id: <20221014103134.2612781-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225; i=ardb@kernel.org; h=from:subject; bh=NyF2H5u6SSHt3uzfrY8Ee/4XotULnbGHqGD385CL9ws=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjSTqFPgsEpYEjpDJP2AVOhSKSKeK8SpBZkzlKuIwP L8iCz/mJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY0k6hQAKCRDDTyI5ktmPJGEFC/ 99wp7o797LxvAQV8Nu5VAx7iw/0uyKmaPb0Vmt5DQcqfnWNCX+2dBC7zsjSsD7K5WYShIZ/KffQAuX aM7ZkI4vEMdacE9d0xudwRlwgPJwGRFpelAtsVWNzHP0rQ5cD3HubbMDFAZ7MRwJRUX96VcDbiBBOY bmL8tZTW0fTQ1IsyU9DEntGMsr5b/olMPp1/lTDY4k+SK6WA8BNPuL1XCkOIi4Mcfu6yl9GJRf7RFe gdXPdSPY3yItUcITzvjPMEWf20XuqPCm/rBnkZRnch/h2eoSUUfYyTZ02nJlzW1LX68lLSSvo0M7cg M4PAl+EANcRG2CA9YVYphtDoFbKeTkVw08Y6E0RRsboAQBBJmDXrdn/7CsrRKFNChzfU4JzHF7Mc1Z VnckrR4GEie80XA8PUDLI7ozdJVa4I1vGy2K7+4UU5QJenAucM2emq7HOwY4T6b6TgURBMlllk7Y1D qj0K8up1v7Jld7TYLhX2MzOVcxhgJzu/tH6/PO6n3GBfE=
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

Amadeusz reports KASAN use-after-free errors introduced by commit
3881ee0b1edc ("efi: avoid efivars layer when loading SSDTs from
variables"). The problem appears to be that the memory that holds the
new ACPI table is now freed unconditionally, instead of only when the
ACPI core reported a failure to load the table.

So let's fix this, by omitting the kfree() on success.

Link: https://lore.kernel.org/all/a101a10a-4fbb-5fae-2e3c-76cf96ed8fbd@linux.intel.com/
Fixes: 3881ee0b1edc ("efi: avoid efivars layer when loading SSDTs from variables")
Reported-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 9624735f1575..3ecdc43a3f2b 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -271,6 +271,8 @@ static __init int efivar_ssdt_load(void)
 			acpi_status ret = acpi_load_table(data, NULL);
 			if (ret)
 				pr_err("failed to load table: %u\n", ret);
+			else
+				continue;
 		} else {
 			pr_err("failed to get var data: 0x%lx\n", status);
 		}
-- 
2.35.1

