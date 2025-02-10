Return-Path: <linux-efi+bounces-2785-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791F8A2F9A6
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 20:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1F23A39CF
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 19:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2474D25C6FF;
	Mon, 10 Feb 2025 19:58:54 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3C325C6E2;
	Mon, 10 Feb 2025 19:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217534; cv=none; b=u1erFEeVw5dMgJCT/+CBj8QNzqbdx64dosCtj9bq1LCS8L48HbTTgzp8fLyJahbNdgI2oCpLla9PICcAg87QeGprAGW7j6PpHu7U1CRwwZIgEnuzQ5c16hEGdyqBXjZXQbjYDC75BddIs/br8IWDCLeoIgSjKNPNvk+YLVTGJ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217534; c=relaxed/simple;
	bh=PNIM2nvS+oM+kXk3ZFDMX8nqLjD92ZayFZQf+DB0PS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBaDhzROTgFCskV3NxZ3517CBHoDG95TLM0Eh/m8+rCxhHGtTOQYKG805T+m74DS+YuWQQW+Xp89KKWUf+la/nzdBVN4md222PLghIalyttvFyv80EeTTKAv/3g6HTY6jyFfdHNjWgB1fHUFHiCjSOZzsJlxc9LFDp9/ahTkdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 6662A30008F12;
	Mon, 10 Feb 2025 20:58:48 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 520FE4649DE; Mon, 10 Feb 2025 20:58:48 +0100 (CET)
Date: Mon, 10 Feb 2025 20:58:48 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Aditya Garg <gargaditya08@live.com>
Cc: Lleyton Gray <lleyton@fyralabs.com>, Ard Biesheuvel <ardb@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: [PATCH] x86/efistub: Add options for forcing Apple set_os
 protocol
Message-ID: <Z6paeFrjdv7L3mtv@wunner.de>
References: <20241228202212.89069-1-lleyton@fyralabs.com>
 <Z3EdkuCBzTGzTHK3@wunner.de>
 <CAMj1kXHWoD78QdFnEY_=Mtz02zN3rhN5+Skgv=fHG91TD8Mmvw@mail.gmail.com>
 <Z3EmoNWbkbYZ7NZO@wunner.de>
 <CAMj1kXEb9NPSwEr2brHYJtFQhnW55hoPycjcAgoPAfjU5ZFqZw@mail.gmail.com>
 <abe2274b-4341-4212-85a8-113273ce1b18@fyralabs.com>
 <PN3PR01MB7728B4C94846673A5FFACE29B80B2@PN3PR01MB7728.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN3PR01MB7728B4C94846673A5FFACE29B80B2@PN3PR01MB7728.INDPRD01.PROD.OUTLOOK.COM>

Hi Aditya,

sorry for the delay!

On Wed, Jan 01, 2025 at 11:39:13AM +0000, Aditya Garg wrote:
> We have had issues with other people unable to use their eGPU if their
> Mac doesn't have the apple set os quirk. We probably could do dual VGA
> checks suggested by Lukas, but will it work with GPU hotplug?

FWIW, below would be my suggestion for replacing the DMI-based quirk
with one that is based on the number of GPUs.

It should invoke the apple_set_os protocol both on dual GPU laptops
as well as ones with an eGPU, hence my expectation is that it should
fix the issue reported by Lleyton.

The quirk is not applied e.g. on single GPU MacBook Airs, hence
should avoid regressing those.

The patch is compile-tested only.

It performs one additional 16-bit config space read for every PCI
device in the system.  If anyone objects to that and wants it
constrained to Apple systems, that could be changed easily.

Thanks,

Lukas

-- >8 --

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 863910e9eefc..3092a6e5166f 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -27,6 +27,7 @@ const efi_system_table_t *efi_system_table;
 const efi_dxe_services_table_t *efi_dxe_table;
 static efi_loaded_image_t *image = NULL;
 static efi_memory_attribute_protocol_t *memattr;
+static unsigned int nr_gpus;
 
 typedef union sev_memory_acceptance_protocol sev_memory_acceptance_protocol_t;
 union sev_memory_acceptance_protocol {
@@ -39,6 +40,23 @@ union sev_memory_acceptance_protocol {
 	} mixed_mode;
 };
 
+static void update_nr_gpus(efi_pci_io_protocol_t *pci)
+{
+	efi_status_t status;
+	u16 class;
+
+	status = efi_call_proto(pci, pci.read, EfiPciIoWidthUint16,
+				PCI_CLASS_DEVICE, 1, &class);
+
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to read device class\n");
+		return;
+	}
+
+	if (class >> 8 == PCI_BASE_CLASS_DISPLAY)
+		nr_gpus++;
+}
+
 static efi_status_t
 preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 {
@@ -150,6 +168,8 @@ static void setup_efi_pci(struct boot_params *params)
 			params->hdr.setup_data = (unsigned long)rom;
 
 		data = (struct setup_data *)rom;
+
+		update_nr_gpus(pci);
 	}
 }
 
@@ -203,37 +223,6 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 	}
 }
 
-static bool apple_match_product_name(void)
-{
-	static const char type1_product_matches[][15] = {
-		"MacBookPro11,3",
-		"MacBookPro11,5",
-		"MacBookPro13,3",
-		"MacBookPro14,3",
-		"MacBookPro15,1",
-		"MacBookPro15,3",
-		"MacBookPro16,1",
-		"MacBookPro16,4",
-	};
-	const struct efi_smbios_type1_record *record;
-	const u8 *product;
-
-	record = (struct efi_smbios_type1_record *)efi_get_smbios_record(1);
-	if (!record)
-		return false;
-
-	product = efi_get_smbios_string(record, product_name);
-	if (!product)
-		return false;
-
-	for (int i = 0; i < ARRAY_SIZE(type1_product_matches); i++) {
-		if (!strcmp(product, type1_product_matches[i]))
-			return true;
-	}
-
-	return false;
-}
-
 static void apple_set_os(void)
 {
 	struct {
@@ -243,7 +232,7 @@ static void apple_set_os(void)
 	} *set_os;
 	efi_status_t status;
 
-	if (!efi_is_64bit() || !apple_match_product_name())
+	if (!efi_is_64bit() || nr_gpus < 2)
 		return;
 
 	status = efi_bs_call(locate_protocol, &APPLE_SET_OS_PROTOCOL_GUID, NULL,

