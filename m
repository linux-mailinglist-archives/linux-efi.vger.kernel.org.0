Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA00677630
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jan 2023 09:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjAWITz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Jan 2023 03:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjAWITx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Jan 2023 03:19:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1FC1A947;
        Mon, 23 Jan 2023 00:19:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76C4660CF3;
        Mon, 23 Jan 2023 08:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54E7C433EF;
        Mon, 23 Jan 2023 08:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674461991;
        bh=MxoEHRPfARVZoKWI3tfsB6o+VliindXdGwA1/dGoFLw=;
        h=From:To:Cc:Subject:Date:From;
        b=o6WXCShzzPUWx39NFGbagruYE7QduyykGQ5QEU7bSSCNJiaa3rOgskPunB0yO4Gs+
         LIwQlP5merhS9pjGgCenxKrtjYQTYjGHgpgBho8+fu05+GwBZtakgfWqnU2PfmrEbm
         E1fhBbD+VvR/IMTMV/tLsh6CvXJMTLQl4Xumz4ysOmwRkmG5HbyY1ZE1Dn5/7uNxmb
         9WUmeR0VH/s3gwuEQKrpJyTjuC9LIwniWgB0ck2iUMvltfAw0DfxCosFPY3o54492s
         tVp9ZPN/+hm3lT6P2mMoZkdLDkXU0kc3sZpqj8oYMHfOb5QWjpFZyo3ppyGkh4WJy+
         9DyYdkhYoem0A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pJs3P-00076g-V3; Mon, 23 Jan 2023 09:19:48 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        kernel test robot <lkp@intel.com>, linux-efi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2] efi: drop obsolete efivars sysfs documentation
Date:   Mon, 23 Jan 2023 09:19:05 +0100
Message-Id: <20230123081905.27283-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The efivars sysfs interface was removed by commit 0f5b2c69a4cb ("efi:
vars: Remove deprecated 'efivars' sysfs interface").

Remove also the corresponding sysfs ABI documentation.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

Changes in v2
 - drop reference in gsmi sysfs documentation
 - drop reference in efivarfs.rst (kernel test robot)


 .../ABI/stable/sysfs-firmware-efi-vars        | 79 -------------------
 Documentation/ABI/testing/sysfs-firmware-gsmi |  8 --
 Documentation/filesystems/efivarfs.rst        |  1 -
 3 files changed, 88 deletions(-)
 delete mode 100644 Documentation/ABI/stable/sysfs-firmware-efi-vars

diff --git a/Documentation/ABI/stable/sysfs-firmware-efi-vars b/Documentation/ABI/stable/sysfs-firmware-efi-vars
deleted file mode 100644
index 46ccd233e359..000000000000
--- a/Documentation/ABI/stable/sysfs-firmware-efi-vars
+++ /dev/null
@@ -1,79 +0,0 @@
-What:		/sys/firmware/efi/vars
-Date:		April 2004
-Contact:	Matt Domsch <Matt_Domsch@dell.com>
-Description:
-		This directory exposes interfaces for interactive with
-		EFI variables.  For more information on EFI variables,
-		see 'Variable Services' in the UEFI specification
-		(section 7.2 in specification version 2.3 Errata D).
-
-		In summary, EFI variables are named, and are classified
-		into separate namespaces through the use of a vendor
-		GUID.  They also have an arbitrary binary value
-		associated with them.
-
-		The efivars module enumerates these variables and
-		creates a separate directory for each one found.  Each
-		directory has a name of the form "<key>-<vendor guid>"
-		and contains the following files:
-
-		=============== ========================================
-		attributes:	A read-only text file enumerating the
-				EFI variable flags.  Potential values
-				include:
-
-				EFI_VARIABLE_NON_VOLATILE
-				EFI_VARIABLE_BOOTSERVICE_ACCESS
-				EFI_VARIABLE_RUNTIME_ACCESS
-				EFI_VARIABLE_HARDWARE_ERROR_RECORD
-				EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS
-
-				See the EFI documentation for an
-				explanation of each of these variables.
-
-		data:		A read-only binary file that can be read
-				to attain the value of the EFI variable
-
-		guid:		The vendor GUID of the variable.  This
-				should always match the GUID in the
-				variable's name.
-
-		raw_var:	A binary file that can be read to obtain
-				a structure that contains everything
-				there is to know about the variable.
-				For structure definition see "struct
-				efi_variable" in the kernel sources.
-
-				This file can also be written to in
-				order to update the value of a variable.
-				For this to work however, all fields of
-				the "struct efi_variable" passed must
-				match byte for byte with the structure
-				read out of the file, save for the value
-				portion.
-
-				**Note** the efi_variable structure
-				read/written with this file contains a
-				'long' type that may change widths
-				depending on your underlying
-				architecture.
-
-		size:		As ASCII representation of the size of
-				the variable's value.
-		=============== ========================================
-
-
-		In addition, two other magic binary files are provided
-		in the top-level directory and are used for adding and
-		removing variables:
-
-		=============== ========================================
-		new_var:	Takes a "struct efi_variable" and
-				instructs the EFI firmware to create a
-				new variable.
-
-		del_var:	Takes a "struct efi_variable" and
-				instructs the EFI firmware to remove any
-				variable that has a matching vendor GUID
-				and variable key name.
-		=============== ========================================
diff --git a/Documentation/ABI/testing/sysfs-firmware-gsmi b/Documentation/ABI/testing/sysfs-firmware-gsmi
index 7a558354c1ee..60fe880b5b44 100644
--- a/Documentation/ABI/testing/sysfs-firmware-gsmi
+++ b/Documentation/ABI/testing/sysfs-firmware-gsmi
@@ -16,14 +16,6 @@ Description:
 
 		Layout:
 
-		/sys/firmware/gsmi/vars:
-
-			This directory has the same layout (and
-			underlying implementation as /sys/firmware/efi/vars.
-			See `Documentation/ABI/*/sysfs-firmware-efi-vars`
-			for more information on how to interact with
-			this structure.
-
 		/sys/firmware/gsmi/append_to_eventlog - write-only:
 
 			This file takes a binary blob and passes it onto
diff --git a/Documentation/filesystems/efivarfs.rst b/Documentation/filesystems/efivarfs.rst
index 0551985821b8..164611ce6f2c 100644
--- a/Documentation/filesystems/efivarfs.rst
+++ b/Documentation/filesystems/efivarfs.rst
@@ -40,4 +40,3 @@ accidentally.
 *See also:*
 
 - Documentation/admin-guide/acpi/ssdt-overlays.rst
-- Documentation/ABI/stable/sysfs-firmware-efi-vars
-- 
2.39.1

